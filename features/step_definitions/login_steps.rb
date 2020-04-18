Given('I login with {string} and {string}') do |email, password|
  @login_page.go_to_login_page
  @login_page.login(email, password)
end

Then('I must be authenticated') do
  expect(find_user_token.length).to be 147
end

Then('I must be see {string} in the logged area') do |user_name|
  expect(@sidebar_page.find_user_name).to eql user_name
end

Then('I must not be authenticated') do
  expect(find_user_token).to be nil
end

Then('I must be see the alert message {string}') do |expect_message|
  expect(@login_page.check_alert_message).to eql expect_message
end
