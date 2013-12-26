class OrdersController < ApplicationController

  def index
    @orders = Order.all.includes(:item, :customer)
    @group_order = GroupOrder.new(orders: @orders)
  end

  def new
    @order = Order.new(item: Item.new, customer: User.new)
  end

  def create
    customer = User.find_or_create_by(name: params[:order][:customer][:name])
    item = Item.find_or_create_by(name: params[:order][:item][:name], price: params[:order][:item][:price])
    Order.create(customer: customer, item: item)
    redirect_to :action => :index
  end
end