class Order < ApplicationRecord
  has_many :sender_recipients, as: :reactionable, dependent: :destroy

  ORDER_PARAMS = %i(rental_period cost).freeze

  validates :rental_period, numericality: { greater_than: Settings.rental_period_min,
    less_than_or_equal_to: Settings.rental_period_max }
end
