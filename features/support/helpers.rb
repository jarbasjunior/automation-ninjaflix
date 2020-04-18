module Helpers
  def find_user_token
    page.execute_script('return window.localStorage.getItem("default_auth_token");')
  end
end
