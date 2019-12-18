class SenderRecipientsController < ApplicationController
  before_action :find_receiver, only: %i(destroy)

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
end
