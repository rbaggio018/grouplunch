class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # attr_accessible :provider, :uid

  has_many :orders, foreign_key: 'customer_id'
  has_many :group_orders, foreign_key: 'customer_id'
  # has_many :transactions

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :balance,
            presence: true,
            numericality: { greater_than_or_equal_to: -999999, less_than_or_equal_to: 999999 }

  def add_balance(amount)
    update_attributes!(balance: balance + amount)
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(
        name: data["name"],
        email: data["email"],
        password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
