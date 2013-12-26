class GroupOrder < ActiveRecord::Base

  belongs_to :customer, class_name: "User"
  has_many :orders

  def sum
    orders.inject(0) do |sum, order|
      sum += order.item.price
    end
  end
end
