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

end
