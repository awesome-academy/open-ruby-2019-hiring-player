module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".base_title"
    
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def show_comment comment_id
    Comment.find_by(id: comment_id)&.comment
  end

  def get_image object
    object.avatar.url ? object.avatar.url : Settings.avatar
  end

  def list_comment object
    object.passive_comment.order_comment
  end

  def count_notifications
    SenderRecipient.unread(current_user.id).notification.count
  end

  def get_user_name user_id
    @user_name ||= User.find_by(id: user_id).name
  end
  
  def rating_reactionable user_id
    SenderRecipient.ratings user_id
  end

  def average_rating user_id
    rating = Rating.by_ids(rating_reactionable user_id).pluck(:rating)
    if rating.empty?
      average_rating = Settings.rating_empty
    else
      average_rating = rating.inject{ |sum, el| sum + el }.to_f / rating.size
      average_rating.round(Settings.average_rating)
    end
  end

  def user_message object
    msg = Messenger.find_by id: object.reactionable_id

    return msg.message if msg
    flash[:danger] = t ".not_found_user" 
    redirect_to root_path

  end

  def find_user_profile id
    user = User.find_by id: id

    return user.user_profile if user
    flash[:danger] = t ".not_found_messenger" 
    redirect_to root_path
  end
end
