# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show favorites edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @title = 'ユーザー一覧'
    @users = User.all
    @pic = current_user.pictures.build
  end

  def show
    @pictures = @user.pictures
    @favorite_pictures = @user.favorite_pictures
  end

  def favorites
    @favorite_pictures = @user.favorite_pictures
    @pictures = @user.favorite_pictures
    render 'users/show'
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    @user.image.attach(params[:user][:image])
    @user.image = 'default.png'
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'your account was updated'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def follows
    @title = 'Follows'
    user = User.find(params[:id])
    @users = user.followings
    render 'index'
  end

  def followers
    @title = 'Followers'
    user = User.find(params[:id])
    @users = user.followers
    render 'index'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:image, :username, :name, :email, :link, :profile, :sex, :tel)
  end

  def require_same_user
    if (current_user != @user) && !current_user.admin?
      flash[:dander] = '他人のアカウントに茶々入れたらダメだよ'
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:dander] = '管理者しかできないアクションだよ'
      redirect_to root_path
    end
  end
end
