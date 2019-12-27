class CommentsController < ApplicationController
  before_action :find_comment, only: %i(show destroy)
  before_action :logged_in_user, only: %i(create destroy)

  def create
    @comment = Comment.new comment_params
    
    if @comment.save
      @comment_reactionable = current_user.active_comment.build receiver_id: params[:user_id], reactionable: @comment
      
      if @comment_reactionable.save
        respond_to :js
      else
        flash.danger[:success] = t ".danger_comment"
        redirect_to request.referrer || root_path
      end
    else
      flash.danger[:success] = t ".danger_comment"
      redirect_to request.referrer || root_path
    end
  end

  def show; end

  def destroy
    @comment.destroy
    if @comment.destroyed?
      flash[:success] = t ".success_destroy_comment"
    else
      flash[:danger] = t ".danger_destroy_comment"
    end
    redirect_to request.referrer || root_path
  end

  private

  def comment_params
    params.require(:comment).permit Comment::COMMENT_PARAMS
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    redirect_to root_path unless @comment
  end
end
