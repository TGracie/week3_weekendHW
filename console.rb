require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require('pry')

Customer.delete_all()
Film.delete_all()
# Ticket.delete_all()

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

film1 = Film.new({
  'title' => 'Moana',
  'price' => 10
  })

film2 = Film.new({
  'title' => 'The Incredibles: 2',
  'price' => 10
  })

film1.save
film2.save

#######################################################################
#######################################################################
## TICKETS ##

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket2 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film1.id
  })

ticket3 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
  })

ticket4 = Ticket.new({
  'customer_id' => customer4.id,
  'film_id' => film2.id
  })

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()

#######################################################################
#######################################################################
binding.pry
nil
