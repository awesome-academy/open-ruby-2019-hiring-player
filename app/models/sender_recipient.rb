class SenderRecipient < ApplicationRecord
  belongs_to :reactionable, polymorphic: true, optional: true
  belongs_to :sender, class_name: User.name
  belongs_to :receiver, class_name: User.name
end
