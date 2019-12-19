class Follow < ApplicationRecord
  has_many :sender_recipients, as: :reactionable
end
