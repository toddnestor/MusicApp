class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :redirect_if_not_user, only: [:show]

  def create
    user = User.new(user_params)

    if user.save
      add_message("Thanks for joining, check your e-mail to activate your account!")
      redirect_to new_session_url
    else
      add_errors(user.errors.full_messages)
      redirect_to new_user_url
    end
  end

  def activate
    user = User.find_by_activation_token(params[:token])

    if user
      user.activate!
      login(user)
      add_message("Thanks for activating your account!")
      redirect_to user_url(user)
    else
      add_error("I'm sorry, something went wrong, please try again!")
      redirect_to new_session_url
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
