require_relative('../db/sql_runner.rb')

class Ticket
  #####################################################################
  attr_reader(:id, :customer_id, :film_id)
  #####################################################################

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end
  #####################################################################
  #####################################################################
  ## CLASS METHODS ##

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map{|ticket| Ticket.new(ticket)}
    return result
  end

  #####################################################################
  #####################################################################
  ## OBJECT METHODS ##

  def save()
    sql = "INSERT INTO tickets
          (customer_id,
           film_id)
    VALUES
          ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end
  #####################################################################

  def update()
    sql = "UPDATE tickets
           SET
           customer_id = $1,
           film_id = $2
           WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end
  #####################################################################

  def delete()
    sql = "DELETE FROM tickets
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  #####################################################################


#######################################################################
#######################################################################
#######################################################################
end ## CLASS END ##
