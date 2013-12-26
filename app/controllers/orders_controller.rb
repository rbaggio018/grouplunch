class OrdersController < ApplicationController

  def index
    @orders = Order.all.includes(:item, :customer)
    @group_order = GroupOrder.new(orders: @orders)
  end

  def new
    @order = Order.new(item: Item.new, customer: User.new)
  end

  def create
    Order.create(order_params)
    redirect_to :action => :index
  end

  private

    def order_params
      params.require(:order).permit(item_attributes: [:name, :price], customer_attributes: [:name])
    end
end