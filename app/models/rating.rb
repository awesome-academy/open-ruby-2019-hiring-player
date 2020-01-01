class Rating < ApplicationRecord
  has_one :sender_recipient, as: :send_recieve

  RATING_PARAMS = %i(rating).freeze
end
