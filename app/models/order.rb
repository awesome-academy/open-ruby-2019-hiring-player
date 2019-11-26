class Order < ApplicationRecord
  has_many :sender_recipient, as: :send_recieve
  has_one :sender_recipient, as: :send_recieve
end
