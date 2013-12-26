class Order < ActiveRecord::Base

  belongs_to :item
  belongs_to :customer, class_name: 'User'
  belongs_to :group_order

  accepts_nested_attributes_for :item, :customer
end
