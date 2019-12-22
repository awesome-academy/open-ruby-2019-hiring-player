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
end
