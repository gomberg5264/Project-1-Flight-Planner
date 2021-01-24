class Flight < ApplicationRecord
  has_and_belongs_to_many :users
  has_one :departure_airport
  has_one :arrival_airport
end
