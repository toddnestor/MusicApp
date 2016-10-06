class UserMailer < ApplicationMailer
  def activation_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to the MusicApp, please activate your account!")
  end
end
