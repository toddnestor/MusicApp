class CommentsController < ApplicationController
  before_action :set_user, only: [:show]
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

  private
  def comment_params
    params.require(:comment).permit(:commentable_type,:commentable_id,:text)
  end
end
