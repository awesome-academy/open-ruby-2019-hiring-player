class User < ApplicationRecord
  has_secure_password

  has_one :user_profile, dependent: :destroy

  has_many :active, class_name: SenderRecipient.name, foreign_key: :sender_id
  has_many :active_follow, ->{where reactionable_type: Follow.name}, class_name: SenderRecipient.name,
    foreign_key: :sender_id
  has_many :active_comment, ->{where reactionable_type: Comment.name}, class_name: SenderRecipient.name,
    foreign_key: :sender_id
  has_many :active_rating, ->{where reactionable_type: Rating.name}, class_name: SenderRecipient.name,
    foreign_key: :sender_id
  has_many :active_order, ->{where reactionable_type: Order.name}, class_name: SenderRecipient.name,
    foreign_key: :sender_id
  has_many :active_messenger, ->{where reactionable_type: Messenger.name}, class_name: SenderRecipient.name,
    foreign_key: :sender_id
  has_many :passive, class_name: SenderRecipient.name, foreign_key: :receiver_id
  has_many :passive_follow, ->{where reactionable_type: Follow.name}, class_name: SenderRecipient.name,
    foreign_key: :receiver_id
  has_many :passive_comment, ->{where reactionable_type: Comment.name}, class_name: SenderRecipient.name,
    foreign_key: :receiver_id
  has_many :passive_rating, ->{where reactionable_type: Rating.name}, class_name: SenderRecipient.name,
    foreign_key: :receiver_id
  has_many :passive_order, ->{where reactionable_type: Order.name}, class_name: SenderRecipient.name,
    foreign_key: :receiver_id
  has_many :passive_messenger, ->{where reactionable_type: Messenger.name}, class_name: SenderRecipient.name,
    foreign_key: :receiver_id
  has_many :following, through: :active_follow, source: :receiver
  has_many :followers, through: :passive_follow, source: :sender

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
  scope :except_user, ->(user_id) { where.not(id: user_id) }

  delegate :name, :email, to: :sender_recipients, prefix: :user, allow_nil: true

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                    BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end
  end

  def follow other_user
    following << other_user
  end

  def unfollow other_user
    following.delete other_user
  end
  
  def following? other_user
    following.include? other_user
  end
end
