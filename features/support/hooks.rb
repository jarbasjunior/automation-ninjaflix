Before do
  @login_page = LoginPage.new
  @sidebar_page = SideBarPage.new
  page.current_window.resize_to(1440, 900)
end
