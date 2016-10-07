class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :check_if_admin, only: [:edit, :destroy, :update]

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login(user)
    session[:session_token] = user.session_token
  end

  def logout(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def add_errors(msgs)
    msgs.each {|msg| add_error(msg)}
  end

  def add_notification(msg)
    add_message(msg, 'info')
  end

  def add_error(msg)
    add_message(msg, 'danger')
  end

  def add_message(msg, css_class='success')
    flash[:messages] ||= []
    flash[:messages] << {msg: msg, class: css_class}
  end

  def bounce_to_login
    unless current_user
      add_error("You must be logged in to do that!")
      redirect_to new_session_url
    end
  end

  private
  def check_if_admin
    unless current_user.is_admin?
      add_error("Only admin users can do that.")
      redirect_to :back
    end
  end
end
