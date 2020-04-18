class ListMoviePage
  include Capybara::DSL

  def initialize
    @movie_raw_css = 'table tbody tr'
  end

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

  def remove_movie(title)
    find(:xpath, "//td[text()='#{title}']/../td[6]/button").click
  end

  def has_no_movie?(title)
    page.has_no_css?(@movie_raw_css, text: title)
  end

  def has_movie?(title)
    page.has_css?(@movie_raw_css, text: title)
  end
end
