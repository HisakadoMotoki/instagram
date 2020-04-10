class RelationshipsController < ApplicationController

  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    #個人ページに遷移するよう変更する
    redirect_to root_path
  end


  def destroy
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    #個人ページに遷移するよう変更する
    redirect_to root_path
  end
end
