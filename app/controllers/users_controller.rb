class UsersController < ApplicationController
  before_action :set_user, only: [:show, :make_admin, :destroy]
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

  def index
    check_if_admin
    @users = User.all
  end

  def destroy
    user_name = @user.email
    @user.destroy
    add_message("You deleted #{user_name}!")
    redirect_to users_url
  end

  def make_admin
    check_if_admin
    @user.admin = true
    @user.save
    add_message("You made #{@user.email} an admin user!")
    redirect_to users_url
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
