class SenderRecipientsController < ApplicationController
  before_action :find_receiver, only: %i(destroy)
  before_action :set_notifications, only: %i(index)
  before_action :find_notification, only: %i(update)

  def index
    @notifications = SenderRecipient.unread(current_user.id).notification
    respond_to do |format|
      format.html { render partial: "notifications/index" }
    end
  end

  def create
    @follow_new = Follow.create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    @sender_recipient = SenderRecipient.find_by sender_id: current_user.id, receiver_id: @user.id, reactionable_type: Follow.name
    @sender_recipient.reactionable_id = @follow_new.id
    @sender_recipient.save

    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def update
    if @notification.update checked: true
      redirect_to params[:path]
    else
      flash[:danger] = t ".danger"
      redirect_to request.referrer
    end
  end
  
  def destroy
    if @user
      current_user.unfollow @user
      Follow.find_by(id: @sender_recipient.reactionable_id).destroy
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t ".danger_unfollow"
      redirect_to request.referrer || root_path
    end
  end

  private

  def find_receiver
    @user = SenderRecipient.find_by(id: params[:id]).receiver
    @sender_recipient = SenderRecipient.find_by receiver_id: @user.id
  end

  def set_notifications
    @notifications = SenderRecipient.unread current_user.id
  end

  def find_notification
    @notification = SenderRecipient.find_by id: params[:notification]

    return if @notification
    flash[:danger] = t ".not_found_notification" 
    redirect_to root_path
  end
end
