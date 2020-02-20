require 'rails_helper'
RSpec.describe FollowersController, type: :controller do
  describe "GET #index" do
    before { get :index }
    it "returns a success response" do
      is_expected.to respond_with(200)
    end
  end
end
