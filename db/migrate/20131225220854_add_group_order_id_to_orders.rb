class AddGroupOrderIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :group_order_id, :integer
  end
end
