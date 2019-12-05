class User < ApplicationRecord
  has_secure_password

  USER_PARAMS = %i(name email password password_confirmation).freeze
  
  enum role: %i(user admin)

  has_one :user_profile, dependent: :destroy
  has_one :sender_recipient, dependent: :destroy
  
  validates :name, presence: true, length: {maximum: Settings.username_maximum}
  validates :email, presence: true, length: {maximum: Settings.email_maximum}, 
    format: {with: Settings.validate_email}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.password_minimum}
  
  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                    BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end
  end
end
