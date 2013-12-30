class Transaction < ActiveRecord::Base

  belongs_to :source, class_name: 'User'
  belongs_to :destination, class_name: 'User'

  after_create :update_balances

  validates :source, :destination, presence: true
  validates_associated :source, :destination
  validates :amount,
            presence:true,
            numericality: { greater_than: 0, less_than_or_equal_to: 100000 },
            format: { with: /\A\d+??(?:\.\d{0,2})?\z/ }

  validate :source_cannot_be_destination

  private

    def update_balances
      source.add_balance(amount)
      destination.add_balance(-amount)
    end

    def source_cannot_be_destination
      errors.add(:source, "can't be yourself") if source == destination
    end
end
