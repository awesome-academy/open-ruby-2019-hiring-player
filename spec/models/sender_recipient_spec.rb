require "rails_helper"

RSpec.describe SenderRecipient, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to(:reactionable).optional(true) }
    it { is_expected.to belong_to(:sender).class_name(User.name)}
    it { is_expected.to belong_to(:receiver).class_name(User.name)}
  end
end
