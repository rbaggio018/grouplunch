class AddIndexToItems < ActiveRecord::Migration
  def change
    add_index :items, [:name, :price]
  end
end
