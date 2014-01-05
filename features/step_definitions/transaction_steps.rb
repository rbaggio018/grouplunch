When(/^(.*) receives a transaction of \$(.*) from (.*)$/) do |user, amount, user_from|
  step "I log in as #{user}"

  visit new_transaction_path
  fill_in 'From', with: User.where(name: user_from).first.email
  fill_in 'Amount', with: amount
  click_button 'Receive'
end