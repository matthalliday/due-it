# The first thing you need to configure is which modules you need in your app.
# The default is nothing which will include only core features (password encryption, login/logout).
# Available submodules are: :user_activation, :http_basic_auth, :remember_me,
# :reset_password, :session_timeout, :brute_force_protection, :activity_logging, :external
Rails.application.config.sorcery.submodules = [:remember_me, :reset_password]

Rails.application.config.sorcery.configure do |config|

  config.user_config do |user|
    user.remember_me_for = 1209600
    user.reset_password_mailer = UserMailer

    # -- user_activation --
    # the attribute name to hold activation state (active/pending).
    # Default: `:activation_state`
    #
    # user.activation_state_attribute_name =


    # the attribute name to hold activation code (sent by email).
    # Default: `:activation_token`
    #
    # user.activation_token_attribute_name =


    # the attribute name to hold activation code expiration date.
    # Default: `:activation_token_expires_at`
    #
    # user.activation_token_expires_at_attribute_name =


    # how many seconds before the activation code expires. nil for never expires.
    # Default: `nil`
    #
    # user.activation_token_expiration_period =


    # your mailer class. Required.
    # Default: `nil`
    #
    # user.user_activation_mailer =


    # activation needed email method on your mailer class.
    # Default: `:activation_needed_email`
    #
    # user.activation_needed_email_method_name =


    # activation success email method on your mailer class.
    # Default: `:activation_success_email`
    #
    # user.activation_success_email_method_name =
  end

  # This line must come after the 'user config' block.
  # Define which model authenticates with sorcery.
  config.user_class = "User"
end
