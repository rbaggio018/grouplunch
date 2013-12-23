class User < ActiveRecord::Base

  has_many :orders, foreign_key: 'customer_id'
end
