require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user){ FactoryBot.create :user }
  let!(:other_user){ FactoryBot.create :user }

  describe "Associations" do
    it { is_expected.to have_one(:user_profile).class_name(UserProfile.name) }
    it do
      is_expected.to have_many(:active).class_name(SenderRecipient.name)
        .with_foreign_key(:sender_id)
    end
    it do
      is_expected.to have_many(:active_follow).class_name(SenderRecipient.name)
        .with_foreign_key(:sender_id)
        .conditions(reactionable_type: Follow.name)
    end
    it do
      is_expected.to have_many(:active_comment).class_name(SenderRecipient.name)
        .with_foreign_key(:sender_id)
        .conditions(reactionable_type: Comment.name)
    end
    it do
      is_expected.to have_many(:active_rating).class_name(SenderRecipient.name)
        .with_foreign_key(:sender_id)
        .conditions(reactionable_type: Rating.name)
    end
    it do
      is_expected.to have_many(:active_order).class_name(SenderRecipient.name)
        .with_foreign_key(:sender_id)
        .conditions(reactionable_type: Order.name)
    end
    it do
      is_expected.to have_many(:passive).class_name(SenderRecipient.name)
        .with_foreign_key(:receiver_id)
    end
    it do
      is_expected.to have_many(:passive_follow).class_name(SenderRecipient.name)
        .with_foreign_key(:receiver_id)
        .conditions(reactionable_type: Follow.name)
    end
    it do
      is_expected.to have_many(:passive_comment).class_name(SenderRecipient.name)
        .with_foreign_key(:receiver_id)
        .conditions(reactionable_type: Comment.name)
    end
    it do
      is_expected.to have_many(:passive_rating).class_name(SenderRecipient.name)
        .with_foreign_key(:receiver_id)
        .conditions(reactionable_type: Rating.name)
    end
    it do
      is_expected.to have_many(:passive_order).class_name(SenderRecipient.name)
        .with_foreign_key(:receiver_id)
        .conditions(reactionable_type: Order.name)
    end
    it { is_expected.to have_many(:following).through(:active_follow).source(:receiver) }
    it { is_expected.to have_many(:followers).through(:passive_follow).source(:sender) }
    it { is_expected.to accept_nested_attributes_for(:user_profile) }
  end
  
  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(Settings.username_maximum) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(Settings.email_maximum) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(Settings.password_minimum) }
  end

  context "when email valid format" do
    it { is_expected.to allow_value("anbinh@gmail.com").for(:email) }
  end

  context "when email invalid format" do
    before{ user.update_attributes(email: "anbinh@gmail") }
    it "Before save" do
      expect(user.errors[:email]).to be_present
    end
  end

  context "when name not presence" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "Class Method" do
    describe ".digest" do
      it "After call digest method" do
        expect(User.digest "123456").not_to be_nil
      end
    end
  end

  describe "Instance Method" do
    describe "#follow" do
      before{ user.follow other_user }
      it "Follow success" do
        expect(user.follow other_user).to_not be_nil
      end
    end

    describe "#unfollow" do
      before{ user.follow other_user }
      it "Unfollow success" do
        expect(user.unfollow other_user).to_not be_nil
      end
    end

    describe "#following?" do
      before{ user.following? other_user }
      it "Following success" do
        expect(user.following? other_user).to_not be_nil
      end
    end
  end
end
