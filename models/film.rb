require_relative('../db/sql_runner.rb')

class Film
  #####################################################################
  attr_reader(:id, :title)
  attr_accessor(:price)
  #####################################################################

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end
  #####################################################################
  #####################################################################
  ## CLASS METHODS ##

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end
  #####################################################################
  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    result = films.map{|film| Film.new(film)}
    return result
  end
  #####################################################################
  #####################################################################
  ## OBJECT METHODS ##

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
      )
      VALUES($1, $2)
      RETURNING id"
      values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end
  #####################################################################

  def update
    sql = "UPDATE films
    SET
      title = $1,
      price = $2
    WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end
  #####################################################################

  def delete()
    sql = "DELETE FROM films
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  #####################################################################

  def customers()
    sql = "SELECT * FROM customers
           INNER JOIN tickets
           ON customers.id = tickets.customer_id
           WHERE film_id = $1;"
    customers = SqlRunner.run(sql, [@id])
    result = customers.map{|customer| Customer.new(customer)}
    return result
  end

#######################################################################
#######################################################################
#######################################################################
end ## CLASS END ##
