class OrdersController < ApplicationController
  before_action :logged_in_user, only: :create

  def new
    @order = Order.new
  end

  def create
    @order = Order.new order_params

    ActiveRecord::Base.transaction do
      if @order.save!
        @order_reactionable = current_user.active_order.build receiver_id: params[:user_id], reactionable: @order          
        save_order_reactionable @order_reactionable
      else
        flash[:danger] = t ".danger_order"
        redirect_to request.referrer || root_path
      end
    end
  end

  private

  def order_params
    params.require(:order).permit Order::ORDER_PARAMS
  end

  def save_order_reactionable object
    if object.save!
      flash[:success] = t ".success_order"
      redirect_to request.referrer
    else
      flash[:danger] = t ".danger_order"
      redirect_to request.referrer
    end
  end
end
