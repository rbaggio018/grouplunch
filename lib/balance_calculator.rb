class BalanceCalculator

  def self.calculate(group_order)
    ratio = group_order.total / group_order.sum
    update_balances_based_on_ratio(group_order.orders, ratio)
    add_total_to_group_order_customer(group_order)
  end

  def self.update_balances_based_on_ratio(orders, ratio)
    orders.each do |order|
      order.customer.add_balance(-(order.item.price * ratio).round(2))
    end
  end

  def self.add_total_to_group_order_customer(group_order)
    group_order.customer.add_balance(group_order.total)
  end

  private_class_method :update_balances_based_on_ratio, :add_total_to_group_order_customer
end