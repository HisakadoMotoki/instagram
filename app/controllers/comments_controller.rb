class CommentsController < ApplicationController

  def create
    @pic = Picture.find(params[:picture_id])
    @comment = @pic.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "投稿にコメントしました"
      @picture = Picture.find(params[:picture_id])
      @picture.create_notification_comment!(current_user)
      redirect_to picture_path(params[:picture_id])
    else
      flash.now[:danger] = '投稿へのコメントに失敗しました。'
      render :index
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to picture_path(params[:picture_id])
    end
  end

  private
  def comment_params
    #params.require(:comment).permit(:content, :picture_id, :user_id)
    params.require(:comment).permit(:content, :picture_id)
  end
end
