class GroupOrdersController < ApplicationController

  def create
    group_order = GroupOrder.new(group_order_params)
    if group_order.customer = User.find_by_name(params[:group_order][:customer][:name])
      GroupOrder.transaction do # need to test transaction
        group_order.save!
        BalanceCalculator.calculate(group_order.reload)
      end
      redirect_to users_path
    else
      flash[:error] = "Please enter valid Name"
      redirect_to orders_path
    end
  end

  private

    def group_order_params
      params.require(:group_order).permit(:total, order_ids: [])
    end
end