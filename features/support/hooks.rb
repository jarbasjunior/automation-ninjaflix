Before do
  @sidebar = SideBar.new
  @sweet_alert = SweetAlert.new
  @login_page = LoginPage.new
  @add_movie_page = AddMoviePage.new
  @list_movie_page = ListMoviePage.new
  page.current_window.resize_to(1440, 900)
end

Before('@login') do
  @login_page.go_to_login_page
  @login_page.login('tony@stark.com', '123456')
end
