class Order < ActiveRecord::Base

  belongs_to :item
  belongs_to :customer, class_name: 'User'
  belongs_to :group_order

  validates :item, :customer, presence: true
  validates_associated :item
end
