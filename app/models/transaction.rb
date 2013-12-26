class Transaction < ActiveRecord::Base

  belongs_to :source, class_name: 'User'
  belongs_to :destination, class_name: 'User'

  after_create :update_balances

  private

    def update_balances
      source.add_balance(amount)
      destination.add_balance(-amount)
    end
end
