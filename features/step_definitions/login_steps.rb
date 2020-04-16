Given('I login with {string} and {string}') do |email, password|
  visit '/'
  @login_page.login(email, password)
end

Then('I must be authenticated') do
  expect(@login_page.find_user_token.length).to be 147
end

Then('I must be see {string} in the logged area') do |user_name|
  expect(@login_page.find_user_name.text).to eql user_name
end
