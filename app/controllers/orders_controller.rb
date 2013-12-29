class OrdersController < ApplicationController

  def index
    @orders = Order.where(group_order_id: nil).includes(:item, :customer)
    @group_order = GroupOrder.new(orders: @orders)
  end

  def new
    @order = Order.new(item: Item.new)
  end

  def create
    item = Item.find_or_create_by({
      name: params[:order][:item][:name],
      specs: params[:order][:item][:specs],
      price: params[:order][:item][:price]
    })
    @order = Order.new(customer: current_user, item: item)

    if @order.save
      flash[:notice] = "Successfully ordered"
      redirect_to :action => :index
    else
      flash[:error] = @order.errors.full_messages.to_sentence
      render :new
    end
  end
end