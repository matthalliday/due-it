class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to log_in_path, notice: "Sign up successful! Check your email for activation instructions."
    else
      render :new
    end
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to log_in_path, notice: "User was successfully activated."
    else
      not_authenticated
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end
end
