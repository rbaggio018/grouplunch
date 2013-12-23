class Order < ActiveRecord::Base

  belongs_to :item
  belongs_to :customer, class_name: 'User'

  accepts_nested_attributes_for :item, :customer
end
