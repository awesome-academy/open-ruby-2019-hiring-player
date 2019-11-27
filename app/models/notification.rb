class Notification < ApplicationRecord
  has_many :sender_recipient, as: :send_recieve
end
