class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new(:item => Item.new, :customer => User.new)
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