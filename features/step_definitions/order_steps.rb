When(/^(.*) makes an order (.*) with price \$(.*)$/) do |user, order, price|
  visit root_url
  fill_in 'Order',  with: order
  fill_in 'Price',  with: price
  fill_in 'Name',   with: user
  click_button 'Place'
end

Then(/^(.*) with price \$(.*) under (.*) should be in the order list$/) do |order, price, user|
  visit orders_url
  page.should have_content order
  page.should have_content price
  page.should have_content user
end

Then(/^(.*) with price \$(.*) under (.*) should not be in the order list$/) do |order, price, user|
  visit orders_url
  page.should_not have_content order
  page.should_not have_content price
  page.should_not have_content user
end