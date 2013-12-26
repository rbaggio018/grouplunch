class User < ActiveRecord::Base

  has_many :orders, foreign_key: 'customer_id'
  has_many :group_orders, foreign_key: 'customer_id'

  def add_balance(extra)
    update_attributes(balance: balance + extra)
  end
end
