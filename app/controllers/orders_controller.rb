class OrdersController < ApplicationController
  before_filter :assign_order, only: [:edit, :update, :destroy]
  before_filter :check_authority, except: [:index, :new, :create]
  before_filter :check_availability, except: [:index, :new, :create]
  before_filter :setup_item, only: [:create, :update]

  def index
    @orders = Order.where(group_order_id: nil).includes(:item, :customer)
    @group_order = GroupOrder.new(orders: @orders)
  end

  def new
    if @order = current_user.order_in_queue
      render :show
    else
      @order = Order.new(item: Item.new)
      render :new
    end
  end

  def create
    if @order = current_user.order_in_queue
      flash[:error] = "You've already ordered. Please wait for group order."
      render :show and return
    end

    @order = Order.new(order_params.merge(customer: current_user, item: @item))

    if @order.save
      flash[:notice] = "Successfully ordered"
      redirect_to root_url
    else
      flash[:error] = readable_error_message
      render :new
    end
  end

  def edit
  end

  def update
    @order.item = @item
    if @order.update_attributes(order_params)
      flash[:notice] = "Successfully updated"
      redirect_to root_url
    else
      flash[:error] = readable_error_message
      render :edit
    end
  end

  def destroy
    @order.destroy!
    flash[:notice] = "Successfully deleted"
    redirect_to root_url
  end

  private

    def order_params
      params.require(:order).permit(:specs)
    end

    def assign_order
      @order = Order.find(params[:id])
    end

    def check_authority
      if @order.customer != current_user
        flash[:alert] = "You don't have access to the order"
        redirect_to root_url and return
      end
    end

    def check_availability
      if @order.group_order
        flash[:error] = "You can't change an order which has been group ordered."
        redirect_to @order.group_order and return
      end
    end

    def setup_item
      @item = Item.find_or_create_by({
        name: params[:order][:item][:name],
        price: params[:order][:item][:price]
      })
    end

    def readable_error_message
      errors = @order.item.errors || @order.errors
      errors.full_messages.to_sentence
    end
end