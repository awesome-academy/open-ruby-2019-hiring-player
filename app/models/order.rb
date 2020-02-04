class Order < ApplicationRecord
  has_many :sender_recipient, as: :send_recieve
  has_one :sender_recipient, as: :send_recieve

  ORDER_PARAMS = %i(rental_period cost).freeze

  validates :rental_period, numericality: { greater_than: Settings.rental_period_min,
    less_than_or_equal_to: Settings.rental_period_max }
end
