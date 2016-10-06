class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :redirect_if_not_user, only: [:show]

  def create
    user = User.new(user_params)

    if user.save
      login(user)
      add_message("Welcome #{user.email}, thanks for joining!")
      redirect_to user_url(user)
    else
      add_errors(user.errors.full_messages)
      redirect_to new_user_url
    end
  end

  private
  def redirect_if_not_user
    redirect_to new_session_url unless @user == current_user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email,:password)
  end
end
