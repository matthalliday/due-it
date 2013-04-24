class UserMailer < ActionMailer::Base
  default from: "matthalliday@gmail.com"

  def activation_needed_email(user)
    @user = user
    @subject = "Welcome to Due It"
    @url = activate_user_url(user.activation_code)
    mail(to: user.email, subject: @subject)
  end

  def activation_success_email(user)
    @user = user
    @subject = "Due It &ndash; Your account is now activated"
    @url = log_in_url
    mail(to: user.email, subject: @subject)
  end

  def reset_password_email(user)
    @user = user
    @subject = "Due It &ndash; Your password reset request"
    @url = edit_password_reset_url(user.reset_password_token)
    mail(to: user.email, subject: @subject)
  end
end
