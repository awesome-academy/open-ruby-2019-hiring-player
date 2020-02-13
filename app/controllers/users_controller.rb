class UsersController < ApplicationController
  before_action :load_user, only: %i(show edit update)
  before_action :load_user_profile, only: :show
  before_action :logged_in_user, only: %i(update)

  def index
    @users = params[:search] ? User.search_name(params[:search]) : User
    @users = @users.page(params[:page]).per Settings.user_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:info] = t ".info"
      redirect_to root_path
    else
      flash.now[:danger] = t ".danger_user"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update update_user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash[:danger] = t ".danger"
      render :edit
    end
  end
  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def update_user_params
    params.require(:user).permit User::USER_UPDATE_PARAMS
  end

  def search_params
    params.permit(:search)
  end
  
  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t ".not_found_user" 
    redirect_to root_path
  end

  def load_user_profile
    @user_profile = @user.user_profile
  end
end
