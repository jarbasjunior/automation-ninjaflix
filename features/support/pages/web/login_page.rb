class LoginPage
  include Capybara::DSL

  def go_to_login_page
    visit '/'
  end

  def login(email, password)
    find('#emailId').set email
    find('#passId').set password
    click_button('Entrar')
  end

  def check_alert_message
    find(:xpath, "//div[@class='card-body']/div[3]/span").text
  end
end
