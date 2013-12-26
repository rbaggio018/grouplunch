When(/^(.*) places a group order with total \$(.*)$/) do |user, total|
  visit orders_path
  fill_in 'Name', with: user
  fill_in 'Total', with: total
  click_button 'Place'
end

Then(/^(.*) should have \$(.*) as balance$/) do |user, balance|
  visit user_path(User.find_by_name(user))
  page.should have_content balance
end