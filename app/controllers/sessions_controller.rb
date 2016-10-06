class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(session_params[:email], session_params[:password])

    if user
      add_message("Welcome back, #{user.email}!")
      login(user)
      redirect_to user_url(user)
    else
      add_errors(user.errors.full_messages)
      redirect_to new_session_url
    end
  end

  def destroy
    logout(current_user)
    add_notification('You have successfully logged out!')
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:user).permit(:email,:password)
  end
end
