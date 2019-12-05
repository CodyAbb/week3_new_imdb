require_relative('../db/sql_runner')
require_relative('./star')
require_relative('./casting')

class Movie

  attr_reader :id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
  end

  def save()
    sql = "INSERT INTO movies
    (
      title,
      genre
    ) VALUES (
      $1, $2
    )
    RETURNING id"
    values = [@title, @genre]
    movie = SqlRunner.run(sql, values).first
    @id = movie['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM movies;"
    movies = SqlRunner.run(sql)
    return map_movies(movies)
  end

  def self.map_movies(movie_data)
    result = movie_data.map { |movie| Movie.new(movie) }
    return result
  end

end
