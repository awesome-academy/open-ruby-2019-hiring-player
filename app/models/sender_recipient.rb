class SenderRecipient < ApplicationRecord
  belongs_to :user
  belongs_to :send_recieve, polymorphic: true
end
