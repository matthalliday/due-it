class SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url
      flash[:success] = "Logged in successfully"
    else
      flash[:error] = "Username or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
    flash[:success] = "Logged out successfully"
  end
end
