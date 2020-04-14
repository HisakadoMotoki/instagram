class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(picture_id: params[:picture_id])
    favorite.save
  #ファボの通知
    @picture=Picture.find(params[:picture_id])
    @picture.create_notification_favorite!(current_user)
    redirect_to picture_path(params[:picture_id])
  end

  def destroy
    favorite = Favorite.find_by(picture_id: params[:picture_id], user_id: current_user.id)
    favorite.destroy
    redirect_to picture_path(params[:picture_id])
  end
end
