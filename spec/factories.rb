FactoryGirl.define do

  factory :order do
    item { FactoryGirl.build :item }
    customer { FactoryGirl.build :user }
  end

  factory :item do
    sequence(:name) { |n| "Item #{n}" }
    price "6.95"
  end

  factory :user do
    sequence(:name) { |n| "User #{n}" }
  end
end