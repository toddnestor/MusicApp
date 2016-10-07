class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :redirect_if_not_user, only: [:show]

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id

    if comment.save
      add_message("Thanks for your comment!")
      redirect_to :back
    else
      add_errors(comment.errors.full_messages)
      redirect_to :back
    end
  end

  def destroy
    @comment.destroy
    add_message("Deleted a comment")
    redirect_to :back
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commentable_type,:commentable_id,:text)
  end

  def check_if_admin
    set_comment
    super unless @comment.user == current_user
  end
end
