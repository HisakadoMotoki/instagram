class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @title = "ユーザー一覧"
    @users = User.all
    @pic = current_user.pictures.build
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @pictures = @user.pictures
    @favorite_pictures = @user.favorite_pictures
  end
  # GET /users/new
  def new
    @user = User.new
  end
  # GET /users/1/edit
  def edit
  end
    
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.image.attach(params[:user][:image])
    @user.image = "default.png"
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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      flash[:success] ="your account was updated"
      #redirect_to root_path
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def follows
    @title = "Follows"
    user = User.find(params[:id])
    @users = user.followings
    render 'index'
  end

  def followers
    @title = "Followers"
    user = User.find(params[:id])
    @users = user.followers
    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:image, :username, :name, :email, :link, :profile, :sex, :tel)
    end
end
