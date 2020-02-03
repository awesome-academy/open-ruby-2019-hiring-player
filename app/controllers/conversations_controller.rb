class ConversationsController < ApplicationController
  before_action :logged_in_user, only: %i(index)

  def index
    @users = User.except_user current_user.id
  end
end
