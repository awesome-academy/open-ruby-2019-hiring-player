class SenderRecipient < ApplicationRecord
  belongs_to :reactionable, polymorphic: true, optional: true
  belongs_to :sender, class_name: User.name
  belongs_to :receiver, class_name: User.name

  validates :receiver_id, presence: true

  scope :order_comment, ->{order created_at: :desc}
  scope :find_receiver, ->(user_id){where receiver_id: user_id}
  scope :find_sender, ->(user_id){where sender_id: user_id}
  scope :unread, -> (user_id){where(checked: false, receiver_id: user_id)}
  scope :notification, -> do
    where(reactionable_type: Comment.name)
    .or(where(reactionable_type: Follow.name))
    .or(where(reactionable_type: Order.name))
    .or(where(reactionable_type: Rating.name))
  end
  scope :ratings, -> (user_id){select(:reactionable_id)
    .where(receiver_id: user_id, reactionable_type: Rating.name)}
  scope :messenger, -> {where(reactionable_type: Messenger.name)}
  scope :find_messenger, -> (sender, receiver) do
    where(sender_id: sender, receiver_id: receiver)
    .or(where(sender_id: receiver, receiver_id: sender))
  end
end
