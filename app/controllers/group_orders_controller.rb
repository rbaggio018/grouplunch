class GroupOrdersController < ApplicationController

  def create
    @group_order = GroupOrder.new(group_order_params)
    @group_order.customer = current_user
    if @group_order.valid?
      GroupOrder.transaction do # transaction is not tested
        @group_order.save
        BalanceCalculator.calculate(@group_order.reload)
      end
      flash[:notice] = "Successfully ordered"
      redirect_to users_path
    else
      flash.now[:error] = @group_order.errors.full_messages.to_sentence
      @orders = @group_order.orders
      render "orders/index"
    end
  end

  def show
    @group_order = GroupOrder.find(params[:id])
  end

  private

    def group_order_params
      params.require(:group_order).permit(:total, order_ids: [])
    end
end