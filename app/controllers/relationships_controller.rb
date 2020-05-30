class RelationshipsController < ApplicationController

  def create
    #@user = User.find(params[:relationship][:following_id])
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    follow.following.create_notification_follow!(current_user)
    redirect_to user_path(params[:user_id])
  end

  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_to user_path(params[:user_id])
  end
end
