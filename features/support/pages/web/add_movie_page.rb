class AddMoviePage
  include Capybara::DSL

  def add_movie(movie)
    find('input[name=title]').set movie['title']
    find('input[placeholder=Status]').click
    find(:xpath, "//ul[@class='el-scrollbar__view el-select-dropdown__list']/li", text: movie['status']).click
    find('input[name=year]').set movie['year']
    find('input[name=release_date]').set movie['release_date']
    
    add_cast(movie['cast'])
    find('textarea[name=overview]').set movie['overview']
    upload(movie['cover'])
    find('#create-movie').click
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
end
