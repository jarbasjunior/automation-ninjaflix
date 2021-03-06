Before do
  @sidebar = SideBar.new
  @sweet_alert = SweetAlert.new
  @login_page = LoginPage.new
  @add_movie_page = AddMoviePage.new
  @list_movie_page = ListMoviePage.new
  page.current_window.resize_to(1440, 900)
end

Before('@login') do
  user = CONFIG['users']['cat_manager']
  @login_page.go_to_login_page
  @login_page.login(user['email'], user['password'])
end

After do |scenario|
  if scenario.failed?
    screenshot_file = page.save_screenshot("log/screenshots/#{scenario.__id__}.png")
    embed(screenshot_file, 'image/png', 'Evidence')
  end
end
