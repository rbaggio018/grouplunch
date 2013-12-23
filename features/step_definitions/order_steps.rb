When(/^I make an order (.*) with price \$(.*) as (.*)$/) do |order, price, user|
  visit root_url
  fill_in 'Order',  :with => order
  fill_in 'Price',  :with => price
  fill_in 'Name',   :with => user
  click_button 'Place'
end

Then(/^(.*) with price \$(.*) under (.*) should be in the order list$/) do |order, price, user|
  page.should have_content order
  page.should have_content price
  page.should have_content user
end