class GroupOrder < ActiveRecord::Base

  belongs_to :customer, class_name: "User"
  has_many :orders

  validates :customer, :orders, presence: true
  validates :total,
            presence:true,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000 },
            format: { with: /\A\d+??(?:\.\d{0,2})?\z/ }

  def sum
    orders.inject(0) do |sum, order|
      sum += order.item.price
    end
  end
end
