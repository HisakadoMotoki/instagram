class PicturesController < ApplicationController
before_action :find_pic, only: [:show, :edit, :update, :destroy, :upvote]
before_action :authenticate_user!, except: [:index, :show]
before_action :correct_user, only: :destroy
before_action :require_same_user, only: [:edit, :update, :destroy]
before_action :require_admin, only: [:destroy]

  def search
    if user_signed_in?
      @pic = current_user.pictures.build
    end
    @pics = Picture.search(params[:search])
  end

  def index
    if user_signed_in?
      @pic = current_user.pictures.build
      @users = current_user && current_user.followings
    else
      @users = User.all
    end
  end

  def create
    @pic_new = current_user.pictures.build(pic_params)
    if @pic_new.save
      redirect_to @pic_new, notice: "投稿されました"
    else
      render 'index'
    end
  end

  def show
    @comment = Comment.new
    @comments = @pic.comments 
  end

  def update
    if @pic.update(pic_params)
      redirect_to @pic, notice: "編集が完了しました"
    else
      render 'edit'
    end
  end

  def destroy
    if @pic.destroy
      redirect_to root_path
    end
  end

  private
  def pic_params
    params.require(:picture).permit(:title, :description, :image)
  end

  def find_pic
    @pic = Picture.find(params[:id])
  end

  def correct_user
    @pic = current_user.pictures.find_by(id: params[:id])
    redirect_to root_url if @pic.nil?
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:dander] = "他人の投稿に茶々入れたらダメだよ"
      redirect_to root_path
    end
  end
  def require_admin
    if logged_in? and !current_user.admin?
      flash[:dander] = "管理者しかできないアクションだよ"
      redirect_to root_path
    end
  end
end
