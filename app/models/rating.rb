class Rating < ApplicationRecord
  has_one :sender_recipient, as: :send_recieve
end
