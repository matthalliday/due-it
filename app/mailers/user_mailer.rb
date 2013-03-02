class UserMailer < ActionMailer::Base
  default from: "matthalliday@gmail.com"

  def reset_password_email(user)
    @user = user
    @url = "http://localhost:3000/password_resets/#{user.reset_password_token}/edit"
    mail(to: user.email, subject: "Your password reset request")
  end

  def activation_needed_email(user)
    @user = user
    @url = "http://localhost:3000/users/#{user.activation_code}/activate"
    mail(to: user.email, subject: "Welcome to My Awesome Site")
  end

  def activation_success_email(user)
    @user = user
    @url = "http://localhost:3000/log-in"
    mail(to: user.email, subject: "Your account is now activated")
  end
end
