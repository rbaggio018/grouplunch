FactoryGirl.define do

  factory :order do
    item { FactoryGirl.create :item }
    customer { FactoryGirl.create :user }
  end

  factory :item do
    sequence(:name) { |n| "Item #{n}" }
    price "6.95"
  end

  factory :user do
    sequence(:name) { |n| "User #{n}" }
  end

  factory :group_order do
    total "20.0"
    orders { 3.times.map { FactoryGirl.create :order } }
    customer { FactoryGirl.create :user }
  end
end