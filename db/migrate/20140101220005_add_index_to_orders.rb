class AddIndexToOrders < ActiveRecord::Migration
  def change
    add_index :orders, :customer_id
    add_index :orders, :item_id
  end
end
