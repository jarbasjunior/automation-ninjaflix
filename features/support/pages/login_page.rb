class LoginPage
  include Capybara::DSL

  def login(email, password)
    find('#emailId').set email
    find('#passId').set password
    click_button('Entrar')
  end

  def find_user_name
    find(:xpath, "//div[@class='user']")
  end

  def find_user_token
    self.find_user_name
    page.execute_script('return window.localStorage.getItem("default_auth_token");')
  end

  def user_token_nil?
    page.execute_script('return window.localStorage.getItem("default_auth_token");')
  end

  def check_alert_message
    find(:xpath, "//div[@class='card-body']/div[3]/span")
  end
end
