class ListMoviePage
  include Capybara::DSL

  def go_add_movie
    find('.nc-simple-add').click
  end

  def check_register(movie)
    record = []
    record << find(:xpath, "//td[text()='#{movie['title']}']").text
    record << find(:xpath, "//td[text()='#{movie['title']}']/../td[3]").text
    record << find(:xpath, "//td[text()='#{movie['title']}']/../td[4]").text
    record << find(:xpath, "//td[text()='#{movie['title']}']/../td[5]").text
    record
  end
end
