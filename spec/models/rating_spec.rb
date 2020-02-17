require "rails_helper"

RSpec.describe Rating, type: :model do
  describe "Associations" do
    it { is_expected.to have_one(:sender_recipient).dependent(:destroy) }
  end
end
