module UsersHelper
  def rating object, sender_id
    id_rating ||= object.passive_rating.find_sender(sender_id).pluck :reactionable_id
    Rating.find_by(id: id_rating).rating
  end

  def rated? object, receiver_id
    object.active_rating.find_receiver(receiver_id).present?
  end
end
