# The first thing you need to configure is which modules you need in your app.
# The default is nothing which will include only core features (password encryption, login/logout).
# Available submodules are: :user_activation, :http_basic_auth, :remember_me,
# :reset_password, :session_timeout, :brute_force_protection, :activity_logging, :external
Rails.application.config.sorcery.submodules = [:remember_me, :reset_password, :user_activation]

Rails.application.config.sorcery.configure do |config|

  config.user_config do |user|
    user.remember_me_for = 1209600
    user.reset_password_mailer = UserMailer
    user.activation_token_attribute_name = :activation_code
    user.activation_token_expires_at_attribute_name = :activation_code_expires_at
    user.activation_token_expiration_period = 604800
    user.user_activation_mailer = UserMailer
  end

  # This line must come after the 'user config' block.
  # Define which model authenticates with sorcery.
  config.user_class = "User"
end
