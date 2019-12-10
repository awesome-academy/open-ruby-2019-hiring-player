class User < ApplicationRecord
  has_secure_password

  has_one :user_profile, dependent: :destroy
  has_one :sender_recipient, dependent: :destroy

  accepts_nested_attributes_for :user_profile

  USER_PARAMS = %i(name email password password_confirmation).freeze
  USER_UPDATE_PARAMS = [:name, :email, :password, :password_confirmation, user_profile_attributes: 
    [:id, :address, :age, :gender, :game, :rank, :hourly_rent, :avatar]].freeze
  
  before_create :build_user_profile

  validates :name, presence: true, length: {maximum: Settings.username_maximum}
  validates :email, presence: true, length: {maximum: Settings.email_maximum}, 
    format: {with: Settings.validate_email}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.password_minimum}
  
  scope :search_name, ->name{where "name LIKE ?", "%#{name}%"}
  
  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                    BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end
  end
end
