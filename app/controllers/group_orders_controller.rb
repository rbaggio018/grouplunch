class GroupOrdersController < ApplicationController

  def create
    @group_order = GroupOrder.new(group_order_params)
    @group_order.customer = User.where(name: params[:group_order][:customer][:name]).first
    if @group_order.valid?
      GroupOrder.transaction do # transaction is not tested
        @group_order.save
        BalanceCalculator.calculate(@group_order.reload)
      end
      flash[:notice] = "Successfully ordered"
      redirect_to users_path
    else
      flash[:error] = @group_order.errors.full_messages.to_sentence
      @orders = @group_order.orders
      render "orders/index"
    end
  end

  private

    def group_order_params
      params.require(:group_order).permit(:total, order_ids: [])
    end
end