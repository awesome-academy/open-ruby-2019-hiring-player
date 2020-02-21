require 'rails_helper'
RSpec.describe OrdersController, type: :controller do
  let(:current_user){ FactoryBot.create(:user) }
  let(:other_user){ FactoryBot.create(:user) }
  let(:order) { FactoryBot.create(:order) }
  let(:order_reactionable){SenderRecipient.create(sender_id: current_user.id,
    receiver_id: other_user.id, reactionable_type: Order.name, 
    reactionable_id: order.id)
  }

  describe "POST #create" do
    describe "create new order" do
      context "create new order success" do
        it{expect{order}.to change{Order.count}.by(1)}
      end
    end

    describe "create new order reactionable" do
      context "create new order success" do
        it{expect{order_reactionable}.to change { SenderRecipient.count }.by(1) }
      end
    end
  end
end
