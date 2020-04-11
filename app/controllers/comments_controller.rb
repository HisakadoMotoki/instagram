class CommentsController < ApplicationController
#before_action :require_user_logged_in?

  def create
    @pic = Picture.find(params[:picture_id])
    @comment = @pic.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "投稿にコメントしました"
      #投稿時ページトップに遷移してしまう
      #render :index
      redirect_to picture_path(params[:picture_id])
    else
      flash.now[:danger] = '投稿へのコメントに失敗しました。'
      #削除時ページトップに遷移してしまう
      render :index
      #redirect_to picture_path(params[:picture_id])
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      #render :index
      redirect_to picture_path(params[:picture_id])
    end
  end


  private

  def comment_params
    #params.require(:comment).permit(:content, :picture_id, :user_id)
    params.require(:comment).permit(:content, :picture_id)
  end

end
