class AddMoviePage
  include Capybara::DSL

  def add_movie(movie)
    find('input[name=title]').set movie['title']
    select_status(movie['status']) unless movie['status'].empty?
    find('input[name=year]').set movie['year']
    find('input[name=release_date]').set movie['release_date']
    
    add_cast(movie['cast'])
    find('textarea[name=overview]').set movie['overview']
    upload(movie['cover']) unless movie['cover'].empty?
    find('#create-movie').click
  end

  def select_status(status)
    find('input[placeholder=Status]').click
    find(:xpath, "//ul[@class='el-scrollbar__view el-select-dropdown__list']/li", text: status).click
  end

  def add_cast(cast)
    field_actor = find(:xpath, "//input[@placeholder='Adicione um ator']")
    cast.each do |actor|
      field_actor.set actor
      field_actor.send_keys :tab
    end
  end

  def upload(file)
    cover_file = File.join(Dir.pwd, "features/support/fixtures/cover/" + file)
    cover_file = cover_file.tr('/', '\\') if OS.windows?

    Capybara.ignore_hidden_elements = false
    attach_file('upcover', cover_file)
    Capybara.ignore_hidden_elements = true
  end

  def alert_text
    find('.alert').text
  end
end
