class PicturesController < ApplicationController
before_action :find_pic, only: [:show, :edit, :update, :destroy, :upvote]
before_action :authenticate_user!, except: [:index, :show]
before_action :correct_user, only: :destroy

  def index
    @pics = Picture.all.order("created_at DESC")
  end
  def new
    @pic = current_user.pictures.build
  end

  def create
    @pic = current_user.pictures.build(pic_params)
    if @pic.save
      redirect_to @pic, notice: "投稿されました"
    else
      render 'new'
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


end
