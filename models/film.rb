require_relative('../db/sql_runner.rb')

class Film
  #####################################################################
  attr_reader(:id, :title)
  attr_accessor(:price)
  #####################################################################

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end
  #####################################################################
  #####################################################################
  ## CLASS METHODS ##

end
