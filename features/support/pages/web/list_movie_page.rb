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

  def remove_movie(title)
    find(:xpath, "//td[text()='#{title}']/../td[6]/button").click
  end

  def confirm_deletion
    find('.swal2-confirm').click
    wait_load_movies
  end  

  def cancel_deletion
    find('.swal2-cancel').click
  end

  def has_no_movie?(title)
    page.has_no_css?('table tbody tr', text: title)
  end

  def has_movie?(title)
    page.has_css?('table tbody tr', text: title)
  end

  def wait_load_movies
     page.has_no_xpath?("//img[@src='/static/img/preloader.gif']")
  end
end
