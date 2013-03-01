class UserMailer < ActionMailer::Base
  default from: "matthalliday@gmail.com"

  def reset_password_email(user)
    @user = user
    @url = "http://localhost:3000/password_resets/#{user.reset_password_token}/edit"
    mail(to: user.email, subject: "Your password reset request")
  end
end
