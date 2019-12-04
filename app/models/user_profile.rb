class UserProfile < ApplicationRecord
  belongs_to :user
  enum gender: %i(male female other)
end
