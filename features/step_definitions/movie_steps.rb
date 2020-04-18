Given('that {string} is a new movie') do |movie_code|
  file = YAML.load_file(File.join(Dir.pwd, 'features/support/fixtures/movies.yaml'))
  @movies = file[movie_code]
  Database.new.delete_movie(@movies['title'])
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
