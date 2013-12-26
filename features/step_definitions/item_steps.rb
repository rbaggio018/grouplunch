Given(/^We have an item named (.*) with price \$(.*)$/) do |name, price|
  FactoryGirl.create(:item, name: name, price: price)
end

Then(/^We should have only one item named (.*) with price \$(.*)$/) do |name, price|
  expect(Item.where(name: name, price: price.to_d).count).to eq(1)
end