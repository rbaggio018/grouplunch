class User < ActiveRecord::Base

  has_many :orders, foreign_key: 'customer_id'
  has_many :group_orders, foreign_key: 'customer_id'
  # has_many :transactions

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :balance, presence: true, numericality: true

  def add_balance(amount)
    update_attributes(balance: balance + amount)
  end
end
