require_relative('../db/sql_runner.rb')

class Customer
  #####################################################################
  attr_reader(:id, :name)
  attr_accessor(:funds, :ticket_count)
  #####################################################################

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
    @ticket_count = 0
  end
  #####################################################################
  #####################################################################
  ## CLASS METHODS ##

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end
  #####################################################################

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    result = customers.map{|customer| Customer.new(customer)}
    return result
  end
  #####################################################################
  #####################################################################
  ## OBJECT METHODS ## CRUD goes here

  def save
    sql = "INSERT INTO customers
    (
      name,
      funds
      )
      VALUES (
        $1, $2
        )
      RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end
  #####################################################################

  def update()
    sql = "UPDATE customers
        SET name = $1,
            funds = $2
        WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end
  #####################################################################

  def delete()
    sql = "DELETE FROM customers
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  #####################################################################
  # def films()
  #   sql = "SELECT films.*
  #          FROM films
  #          INNER JOIN tickets
  #          ON films.id = tickets.film_id
  #          WHERE film_id = $1;"
  #
  #   films = SqlRunner.run(sql, [@id])
  #   result = films.map{|film| Film.new(film)}
  #   return result
  # end
  # returns empty array of films
######################################################################

  def films()
    sql = "SELECT * FROM films
              INNER JOIN tickets
              ON films.id = tickets.film_id
              WHERE customer_id = $1;"

    films = SqlRunner.run(sql, [@id])
    result = films.map{|film| Film.new(film)}
    return result
  end
######################################################################
## basic extension ##
  def ticket_count()
    sql = "SELECT * FROM films
              INNER JOIN tickets
              ON films.id = tickets.film_id
              WHERE customer_id = $1;"

    films = SqlRunner.run(sql, [@id])
    result = (films.map{|film| Film.new(film)}).count
    return result
  end
  ####################################################################
  # def purchase
  #   sql = "SELECT funds - films.price FROM films
  #          INNER JOIN tickets
  #          ON films.id = tickets.film_id
  #          INNER JOIN customers
  #          on customers.id = tickets.customer_id
  #          WHERE customer_id = $1;"
  #   SqlRunner.run(sql, [@customer_id])
  # end
  ####################################################################
  def buy_ticket

    sql_1 = "SELECT funds FROM customers"
    fund_hash = SqlRunner.run(sql_1).first
    funds = fund_hash['funds'].to_i

    sql_2 = "SELECT price FROM films"
    price_hash = SqlRunner.run(sql_2).first
    price = price_hash['price'].to_i # call price key and then to_i the string into something I can use

    remaining_funds = funds -= price
    self.funds = remaining_funds
    self.update
    @ticket_count += 1
    ## funds updated, now to update tickets?

  ## Ticket updated as well
    # sql_3 = "UPDATE tickets
    #        SET
    #        customer_id = $1,
    #        film_id = $2
    #        WHERE id = $3"
    # values = [@id, film_id, @ticket_id]
    # SqlRunner.run(sql_3, values)
  end

######################################################################
######################################################################
######################################################################
end ## CLASS END ##
