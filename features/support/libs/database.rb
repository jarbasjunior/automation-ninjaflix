require 'pg'

class Database
  def delete_movie(title)
    connect_db.exec("delete from movies where title = '#{title}';")
  end

  def connect_db
    connection = PG.connect(host: 'localhost', dbname: 'nflix', user: 'postgres', password: 'qaninja')
  end
end