class CreateGroupOrders < ActiveRecord::Migration
  def change
    create_table :group_orders do |t|
      t.integer :customer_id
      t.decimal :total, precision: 8, scale: 2

      t.timestamps
    end
  end
end
