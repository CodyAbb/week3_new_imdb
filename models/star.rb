require_relative('../db/sql_runner')
require_relative('./movie')
require_relative('./casting')

class Star

  attr_reader :id
  attr_accessor :first_name, :second_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @second_name = options['second_name']
  end

  def save()
    sql = "INSERT INTO stars
    (
      first_name,
      second_name
    ) VALUES (
      $1, $2
    )
    RETURNING id"
    values = [@first_name, @second_name]
    star = SqlRunner.run(sql, values).first
    @id = star['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM stars;"
    stars = SqlRunner.run(sql)
    return map_stars(stars)
  end

  def update()
    sql = "UPDATE stars SET first_name = $1, second_name =$2
    WHERE id = $3"
    values = [@first_name, @second_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM stars WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def movies()
    sql = "SELECT movies.* FROM movies
          INNER JOIN castings
          ON castings.movie_id = movies.id
          WHERE star_id = $1"
    values = [@id]
    movies = SqlRunner.run(sql, values)
    return Movie.map_movies(movies)
  end


  def self.map_stars(star_data)
    result = star_data.map { |star| Star.new(star) }
    return result
  end

end
