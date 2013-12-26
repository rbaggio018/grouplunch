Given(/^(.*) has a balance of \$(.*)$/) do |user, balance|
  FactoryGirl.create(:user, name: user, balance: balance)
end

Then(/^(.*) should have a balance of \$(.*)$/) do |user, balance|
  expect(User.where(name: user).first.balance).to eq(balance.to_d)
end

Given(/^We have a user named (.*)$/) do |name|
  FactoryGirl.create(:user, name: name)
end

Then(/^We should have only one user named (.*)$/) do |name|
  expect(User.where(name: name).count).to eq(1)
end