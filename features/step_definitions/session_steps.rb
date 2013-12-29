Given(/^I log in as (.*)$/) do |name|
  user = User.where(name: name).first || FactoryGirl.create(:user, name: name)
  login_as(user)
end