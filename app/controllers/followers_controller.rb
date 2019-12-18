class FollowersController < ApplicationController
  def index
    @user = User.find_by id: params[:id]
    
    if @user
      @users = @user.followers
    else
      flash[:danger] = t ".danger"
    end
  end
end
