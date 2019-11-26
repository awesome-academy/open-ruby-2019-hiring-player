class Payment < ApplicationRecord
  belongs_to :order, dependent: :destroy
end
