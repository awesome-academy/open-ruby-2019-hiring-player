class UserProfile < ApplicationRecord
  belongs_to :user
  enum gender: %i(male female other)

  mount_uploader :avatar, PictureUploader
end
