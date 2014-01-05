When(/^(.*) places a group order with total \$(.*)$/) do |user, total|
  step "I log in as #{user}"

  visit orders_path
  fill_in 'Total', with: total
  click_button 'Place'
end

Then(/^(.*) should have \$(.*) as balance$/) do |user, balance|
  expect(User.where(name: user).first.balance).to eq(BigDecimal.new(balance))
end