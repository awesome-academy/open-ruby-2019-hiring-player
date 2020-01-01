class SenderRecipient < ApplicationRecord
  belongs_to :reactionable, polymorphic: true, optional: true
  belongs_to :sender, class_name: User.name
  belongs_to :receiver, class_name: User.name

  scope :order_comment, ->{order created_at: :desc}
  scope :find_receiver, ->(user_id){where receiver_id: user_id}
  scope :find_sender, ->(user_id){where sender_id: user_id}
end
