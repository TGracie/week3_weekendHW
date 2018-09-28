require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require('pry')

Customer.delete_all()

#######################################################################
#######################################################################
## CUSTOMERS ##

customer1 = Customer.new({
  'name' => "Thomas Gracie",
  'funds' => 150
  })
customer2 = Customer.new({
  'name' => "Richard Tidy",
  'funds' => 150
  })
customer3 = Customer.new({
  'name' => "Atlanta Pritchard-Barrett",
  'funds' => 150
  })
customer4 = Customer.new({
  'name' => "Camilla Cumming",
  'funds' => 150
  })
  customer1.save()
  customer2.save()
  customer3.save()
  customer4.save()

#######################################################################
#######################################################################
## FILMS ##


#######################################################################
#######################################################################
## TICKETS ##


#######################################################################
#######################################################################
binding.pry
nil
