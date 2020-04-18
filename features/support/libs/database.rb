require 'pg'

class Database
  def delete_movie(title)
    connect_db.exec("delete from movies where title = '#{title}';")
  end

  def insert_movie(movie)
    query = "insert into movies
              (title, status, year, release_date, created_at, updated_at)
            values
              ('#{movie['title']}', '#{movie['status']}', #{movie['year']}, '#{movie['release_date']}', current_timestamp, current_timestamp);"
    connect_db.exec(query)
  end

  def connect_db
    connection = PG.connect(CONFIG['database'])
  end
end