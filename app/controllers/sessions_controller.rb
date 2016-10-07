class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(session_params[:email], session_params[:password])
    user.errors[:must_activate] = "your account by clicking the link we sent you in your e-mail before you can sign in." unless user.nil? || user.activated

    if user && user.errors.empty?
      add_message("Welcome back, #{user.email}!")
      login(user)
      redirect_to user_url(user)
    else
      if user && !user.errors.empty?
        add_errors(user.errors.full_messages)
      else
        add_error("We couldn't find a user with those credentials, please try again.")
      end
      redirect_to new_session_url
    end
  end

  def destroy
    logout(current_user)
    add_notification('You have successfully logged out!')
    redirect_to new_session_url
  end

  def check_if_admin
  end

  private
  def session_params
    params.require(:user).permit(:email,:password)
  end
end
