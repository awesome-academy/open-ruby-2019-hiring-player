class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:info] = t ".info"
      redirect_to root_path
    else
      flash.now[:danger] = t ".danger_user"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end
end
