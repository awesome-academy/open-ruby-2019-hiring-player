require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:current_user){ FactoryBot.create(:user) }
  let(:other_user){ FactoryBot.create(:user) }
  let(:comment) { FactoryBot.create(:comment) }

  describe "POST #create" do
    describe "create new comment" do
      context "create new comment success" do
        it{expect{comment}.to change{Comment.count}.by(1)}
      end
    end

    describe "create new comment reactionable" do
      let(:comment_reactionable){SenderRecipient.create(sender_id: current_user.id,
        receiver_id: other_user.id, reactionable_type: Comment.name, 
        reactionable_id: comment.id)
      }
      context "create new comment success" do
        it{expect{comment_reactionable}.to change { SenderRecipient.count}.by(1) }
      end
    end
  end
end
