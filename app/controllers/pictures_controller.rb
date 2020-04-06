class PicturesController < ApplicationController
before_action :find_pic, only: [:show, :edit, :update, :destroy]

  def index
    @pic = Picture.all
  end
  def new
    @pic = Picture.new
  end

  def create
    @pic = Picture.new(pic_params)
    if @pic.save
      redirect_to @pic, notice: "投稿されました"
    else
      render 'new'
    end
  end
  def show
  end

  private

  def pic_params
    params.require(:picture).permit(:title, :description)
  end

  def find_pic
    @pic = Picture.find(params[:id])
  end


end
