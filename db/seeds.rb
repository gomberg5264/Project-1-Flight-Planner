# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
u1 = User.create :name => "Pamela Glickman", :mobile => "0410196555", :email => 'pamela@gmail.com', :password => "chicken", :admin => true
u2 = User.create :name => "Jackson Sexton", :mobile => "0410555678", :email => 'jackson@gmail.com', :password => "chicken"
puts "#{ User.count } users."

DepartureAirport.destroy_all
d1 = DepartureAirport.create :name => "Moscow Domodedovo Airport", :city => "Moscow", :longitude => 55.4103, :latitude => 37.9025
d2 = DepartureAirport.create :name => "Novosibirsk Tolmachevo Airport", :city => "Novosibirsk", :longitude => 55.0114, :latitude => 82.6522
d3 = DepartureAirport.create :name => "Pulkovo Airport", :city => "Saint Petersburg", :longitude => 59.4801, :longitude => 30.1545
puts "#{ DepartureAirport.count } airports."

ArrivalAirport.destroy_all
a1 = ArrivalAirport.create :name => "Moscow Domodedovo Airport", :city => "Moscow", :longitude => 55.4103, :latitude => 37.9025
a2 = ArrivalAirport.create :name => "Novosibirsk Tolmachevo Airport", :city => "Novosibirsk", :longitude => 55.0114, :latitude => 82.6522
a3 = ArrivalAirport.create :name => "Pulkovo Airport", :city => "Saint Petersburg", :longitude => 59.4801, :longitude => 30.1545
puts "#{ ArrivalAirport.count } airports."

Flight.destroy_all
f1 = Flight.create :code => 'SU123', :date => '2021-05-01', :time => '07:00:00', :seats => 100
f2 = Flight.create :code => 'SU456', :date => '2021-05-05', :time => '19:00:00', :seats => 150
f3 = Flight.create :code => 'SU777', :date => '2021-05-08', :time => '07:00:00', :seats => 300
f4 = Flight.create :code => 'SU888', :date => '2021-05-09', :time => '19:00:00', :seats => 350
puts "#{ Flight.count } flights."

# Associations
puts "Departure Airports and Flights."
d1.flights << f1 << f3
d2.flights << f2
d3.flights << f4

puts "Arrival Airports and Flights."
a1.flights << f2 << f4
a2.flights << f1
a3.flights << f3

puts "Users and Flights."
u1.flights << f1 << f2 << f3
u2.flights << f3 << f4
