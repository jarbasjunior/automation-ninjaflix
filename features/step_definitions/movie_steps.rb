Given('that {string} is a new movie') do |movie_code|
  file = YAML.load_file(File.join(Dir.pwd, 'features/support/fixtures/movies.yaml'))
  @movies = file[movie_code]
  Database.new.delete_movie(@movies['title'])
end

Given('this movies is already exists') do
  Database.new.insert_movie(@movies)
end

When('I make the register this movie') do
  @list_movie_page.go_add_movie
  @add_movie_page.add_movie(@movies)
end 

Then('I must be see a new movie in the list') do
  record = @list_movie_page.check_register(@movies)
  expect(record[0]).to eql @movies['title']
  expect(record[1]).to eql @movies['status']
  expect(record[2]).to eql @movies['year'].to_s
  expect(record[3]).to have_text @movies['release_date']
end

Then('I must be see a {string}') do |expect_alert|
  expect(@add_movie_page.alert_text).to eql expect_alert
end

Given('that {string} is of the catalog') do |movie_code|
  steps %{
    Given that '#{movie_code}' is a new movie
    And this movies is already exists
  }
end

When('I request deletion') do
  @list_movie_page.remove_movie(@movies['title'])
end

When('I confirm deletion') do
  @sweet_alert.confirm
end

Then('this item must be removed in the catalog') do
  expect(@list_movie_page.has_no_movie?(@movies['title'])).to be true
end

When('I cancel deletion') do
  @sweet_alert.cancel
end

Then('this item be remain in the catalog') do
  expect(@list_movie_page.has_movie?(@movies['title'])).to be true
end

