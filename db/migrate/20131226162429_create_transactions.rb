class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :source_id
      t.integer :destination_id
      t.decimal :amount, precision: 8, scale: 2

      t.timestamps
    end
  end
end
