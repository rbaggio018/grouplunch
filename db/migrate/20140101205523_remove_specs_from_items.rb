class RemoveSpecsFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :specs, :string
  end
end
