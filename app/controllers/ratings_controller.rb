class RatingsController < ApplicationController
  before_action :logged_in_user, :new_rating, only: :create

  def create
    if @rating.save
      @rating_reactionable = current_user.active_rating.build receiver_id: params[:user_id], reactionable: @rating

      save_rating_reactionable @rating_reactionable
    else
      flash.now[:danger] = t ".danger_rating"
      redirect_to request.referrer || root_path
    end
  end

  private

  def ratings_params
    params.permit Rating::RATING_PARAMS
  end

  def new_rating
    @rating = Rating.new ratings_params
  end

  def save_rating_reactionable object
    if object.save
      redirect_to "ratings/show"
    else
      flash.now[:danger] = t ".danger_rating"
      redirect_to request.referrer || root_path
    end
  end
end
