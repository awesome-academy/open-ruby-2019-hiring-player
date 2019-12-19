class FollowingsController < ApplicationController
  def index
    @user = User.find_by id: params[:id]

    if @user
      @users = @user.following
    else
      flash[:danger] = t ".danger"
    end
  end
end
