class UserMailer < ActionMailer::Base
  default from: "matthalliday@gmail.com"

  def reset_password_email(user)
    @user = user
    @subject = "Due It: Your password reset request"
    @url = edit_password_reset_url(user.reset_password_token)
    mail(to: user.email, subject: @subject)
  end
end
