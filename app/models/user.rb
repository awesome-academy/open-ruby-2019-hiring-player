class User < ApplicationRecord
  has_one :user_profile, dependent: :destroy
  has_one :sender_recipient, dependent: :destroy
  enum role: %i(user admin)
end
