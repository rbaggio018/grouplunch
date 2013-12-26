Given(/^(.*) has a balance of \$(.*)$/) do |user, balance|
  FactoryGirl.create(:user, name: user, balance: balance)
end

Then(/^(.*) should have a balance of \$(.*)$/) do |user, balance|
  expect(User.find_by_name(user).balance).to eq(balance.to_d)
end