class AddSpecsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :specs, :string
  end
end
