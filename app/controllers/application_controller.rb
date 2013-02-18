class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_authenticated
    redirect_to log_in_path
  end
end
