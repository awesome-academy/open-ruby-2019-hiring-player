require "rails_helper"

RSpec.describe Order, type: :model do
  let!(:order){ FactoryBot.create :order }
  let!(:user){ FactoryBot.create :user }

  describe "Associations" do
    it { is_expected.to have_many(:sender_recipients).dependent(:destroy) }
  end

  describe "Validation" do
    it { is_expected.to validate_numericality_of(:rental_period)
      .is_less_than_or_equal_to(Settings.rental_period_max)
      .is_greater_than(Settings.rental_period_min)
    }
  end

  context "When retal period greater than minimum" do
    before{ order.update_attributes(rental_period: 30) }
    it "Before save" do
      expect(order.errors[:rental_period]).to be_present
    end
  end

end
