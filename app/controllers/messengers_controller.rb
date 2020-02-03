class MessengersController < ApplicationController
  before_action :load_user, only: %i(index)

  def index
    @messengers = SenderRecipient.messenger.find_messenger(current_user.id, params[:user_id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @message = Messenger.new message_params

    ActiveRecord::Base.transaction do
      if @message.save!
        @message_reactionable = current_user.active_messenger.build receiver_id: params[:receiver],
          reactionable: @message
        save_message_reactionable @message_reactionable
      else
        flash.now[:danger] = t ".danger"
        redirect_to request.referrer || root_path
      end
    end
  end

  def show; end

  private

  def message_params
    params.require(:messenger).permit(:message)
  end

  def save_message_reactionable object
    if object.save!
      respond_to :js 
    else
      flash.now[:danger] = t ".danger"
      redirect_to request.referrer
    end
  end

  def load_user
    @user = User.find_by id: params[:user_id]

    return if @user
    flash[:danger] = t ".not_found_user" 
    redirect_to root_path
  end
end
