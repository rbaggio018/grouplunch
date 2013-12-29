Given(/^We have an item named (.*) with (.*) which has price \$(.*)$/) do |name, specs, price|
  FactoryGirl.create(:item, name: name, specs: specs, price: price)
end

Then(/^We should have only one item named (.*) with (.*) which has price \$(.*)$/) do |name, specs, price|
  expect(Item.where(name: name, specs: specs, price: price.to_d).count).to eq(1)
end