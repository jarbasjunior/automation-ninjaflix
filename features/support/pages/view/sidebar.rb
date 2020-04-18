class SideBar
  include Capybara::DSL

  def find_user_name
    find(:xpath, "//div[@class='user']").text
  end

  def find_user_token
    self.find_user_name
  end
end
