require 'rails_helper'

RSpec.describe Airline do
  describe 'User Story 3' do
    it 'see a list of passengers with flights on the airline' do
      airline1 = Airline.create!(name: "DIA")
      airline2 = Airline.create!(name: "LAX")

      flight1 = Flight.create!(number: "3205", date: "02/25/2022", departure_city: "Denver", arrival_city: "Los Angeles", airline_id: airline1.id )
      flight2 = Flight.create!(number: "4505", date: "03/25/2022", departure_city: "Denver", arrival_city: "Huntsville", airline_id: airline1.id )
      flight3 = Flight.create!(number: "5505", date: "03/25/2022", departure_city: "Los Angeles", arrival_city: "Huntsville", airline_id: airline2.id )

      pass1 = Passenger.create!(name: "Beth", age: 16) #1
      pass2 = Passenger.create!(name: "Sue", age: 25) #1
      pass3 = Passenger.create!(name: "Bill", age: 75) #2
      pass4 = Passenger.create!(name: "Joe", age: 25) #3
      pass5 = Passenger.create!(name: "Merk", age: 45) #3
      pass6 = Passenger.create!(name: "Merk", age: 45) #3

      fpass1 = PassengerFlight.create!(passenger_id: pass1.id, flight_id: flight1.id)
      fpass2 = PassengerFlight.create!(passenger_id: pass2.id, flight_id: flight1.id)
      fpass3 = PassengerFlight.create!(passenger_id: pass3.id, flight_id: flight2.id)
      fpass4 = PassengerFlight.create!(passenger_id: pass4.id, flight_id: flight3.id)
      fpass5 = PassengerFlight.create!(passenger_id: pass5.id, flight_id: flight3.id)
      fpass6 = PassengerFlight.create!(passenger_id: pass6.id, flight_id: flight3.id)

      visit airline_path(airline1)

      within(".passenger-#{pass2.id}") do
        expect(page).to have_content("#{pass2.name}")
      end

      expect(page).to_not have_content("#{pass1.name}")
    end
  end
end