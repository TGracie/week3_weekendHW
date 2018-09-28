require_relative('../db/sql_runner.rb')

class Customer
  #####################################################################
  attr_reader(:id, :name)
  attr_accessor(:funds)
  #####################################################################

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
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

end ## CLASS END ##
