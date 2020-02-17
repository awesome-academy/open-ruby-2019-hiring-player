require "rails_helper"

RSpec.describe Follow, type: :model do
  describe "Associations" do
    it { is_expected.to have_many(:sender_recipients).dependent(:destroy) }
  end
end
