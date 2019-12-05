require_relative('../db/sql_runner')
require_relative('./movie')
require_relative('./star')

class Casting

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id'].to_i
    @star_id = options['star_id'].to_i
    @fee = options['fee'].to_i
  end

  def save()
    sql = "INSERT INTO castings
    (
      movie_id,
      star_id,
      fee
    ) VALUES (
      $1, $2, $3
    )
    RETURNING id"
    values = [@movie_id, @star_id, @fee]
    cast = SqlRunner.run(sql, values).first
    @id = cast['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM castings"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM castings;"
    castings = SqlRunner.run(sql)
    return map_castings(castings)
  end

  def self.map_castings(casting_data)
    result = casting_data.map { |casting| Casting.new(casting) }
    return result
  end

end
