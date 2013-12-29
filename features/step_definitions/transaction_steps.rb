When(/^(.*) makes a transaction of \$(.*) to (.*)$/) do |user_from, amount, user_to|
  visit new_transaction_path
  fill_in 'From', with: user_from
  fill_in 'To', with: user_to
  fill_in 'Amount', with: amount
  click_button 'Transfer'
end