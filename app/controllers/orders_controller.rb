class OrdersController < ApplicationController

  def index
    @orders = Order.where(group_order_id: nil).includes(:item, :customer)
    @group_order = GroupOrder.new(orders: @orders)
  end

  def new
    if @order = Order.where(customer: current_user, group_order_id: nil).first
      render :show
    else
      @order = Order.new(item: Item.new)
      render :new
    end
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
      redirect_to root_url
    else
      flash[:error] = @order.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @order = Order.find(params[:id])
    if @order.group_order
      flash[:error] = "Can't edit an order has been group placed"
      redirect_to @order.group_order
    else
      render :edit
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.group_order
      flash[:error] = "Failed to make the change. The order has been group placed."
      redirect_to @order.group_order
    else
      item = Item.find_or_create_by({
        name: params[:order][:item][:name],
        specs: params[:order][:item][:specs],
        price: params[:order][:item][:price]
      })
      @order.item = item
      if @order.save
        flash[:notice] = "Successfully updated"
        render :show
      else
        flash[:error] = @order.errors.full_messages.to_sentence
        render :edit
      end
    end
  end
end