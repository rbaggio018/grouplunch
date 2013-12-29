When(/^(.*) makes an order (.*) with (.*) which has price \$(.*)$/) do |user, order, specs, price|
  visit root_url
  fill_in 'Order',  with: order
  fill_in 'Price',  with: price
  fill_in 'Name',   with: user
  fill_in 'Specs',  with: specs
  click_button 'Place'
end

Then(/^(.*) with (.*) which has price \$(.*) under (.*) should be in the order list$/) do |order, specs, price, user|
  visit orders_url
  page.should have_content order
  page.should have_content specs
  page.should have_content price
  page.should have_content user
end

Then(/^(.*) with (.*) which has price \$(.*) under (.*) should not be in the order list$/) do |order, specs, price, user|
  visit orders_url
  page.should_not have_content order
  page.should_not have_content specs
  page.should_not have_content price
  page.should_not have_content user
end