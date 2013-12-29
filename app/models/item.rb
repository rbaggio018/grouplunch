class Item < ActiveRecord::Base

  has_many :orders

  validates :name, presence: true
  validates :price,
            presence:true,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 },
            format: { with: /\A\d+??(?:\.\d{0,2})?\z/ }
end
