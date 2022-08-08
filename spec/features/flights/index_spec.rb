require 'rails_helper'

RSpec.describe Flight do
  describe 'User Story 1' do
    it 'See all the flight numbers' do
      airline1 = Airline.create!(name: "DIA")
      airline2 = Airline.create!(name: "LAX")

      flight1 = Flight.create!(number: "3205", date: "02/25/2022", departure_city: "Denver", arrival_city: "Los Angeles", airline_id: airline1.id )
      flight2 = Flight.create!(number: "4505", date: "03/25/2022", departure_city: "Denver", arrival_city: "Huntsville", airline_id: airline1.id )
      flight3 = Flight.create!(number: "5505", date: "03/25/2022", departure_city: "Denver", arrival_city: "Huntsville", airline_id: airline2.id )

      visit flights_path

      expect(page).to have_content("Flight: #{flight1.number}")
      expect(page).to have_content("Flight: #{flight2.number}")
      expect(page).to have_content("Flight: #{flight3.number}")
    end

    it 'shows the Airline name' do
      airline1 = Airline.create!(name: "DIA")
      airline2 = Airline.create!(name: "LAX")

      flight1 = Flight.create!(number: "3205", date: "02/25/2022", departure_city: "Denver", arrival_city: "Los Angeles", airline_id: airline1.id )
      flight2 = Flight.create!(number: "4505", date: "03/25/2022", departure_city: "Denver", arrival_city: "Huntsville", airline_id: airline1.id )
      flight3 = Flight.create!(number: "5505", date: "03/25/2022", departure_city: "Los Angeles", arrival_city: "Huntsville", airline_id: airline2.id )

      visit flights_path

      within(".flight-#{flight1.id}") do
        expect(page).to have_content("Flight: #{flight1.number}")
        expect(page).to have_content("Airline: DIA")
        expect(page).to_not have_content("Airline: LAX")
        expect(page).to_not have_content("Flight: #{flight2.number}")
        expect(page).to_not have_content("Flight: #{flight3.number}")
      end

      within(".flight-#{flight2.id}") do
        expect(page).to have_content("Flight: #{flight2.number}")
        expect(page).to have_content("Airline: DIA")
        expect(page).to_not have_content("Airline: LAX")
        expect(page).to_not have_content("Flight: #{flight3.number}")
        expect(page).to_not have_content("Flight: #{flight1.number}")
      end

      within(".flight-#{flight3.id}") do
        expect(page).to have_content("Flight: #{flight3.number}")
        expect(page).to have_content("Airline: LAX")
        expect(page).to_not have_content("Airline: DIA")
        expect(page).to_not have_content("Flight: #{flight1.number}")
        expect(page).to_not have_content("Flight: #{flight2.number}")
      end
    end

    it 'shows the passengers on the flight' do
      airline1 = Airline.create!(name: "DIA")
      airline2 = Airline.create!(name: "LAX")

      flight1 = Flight.create!(number: "3205", date: "02/25/2022", departure_city: "Denver", arrival_city: "Los Angeles", airline_id: airline1.id )
      flight2 = Flight.create!(number: "4505", date: "03/25/2022", departure_city: "Denver", arrival_city: "Huntsville", airline_id: airline1.id )
      flight3 = Flight.create!(number: "5505", date: "03/25/2022", departure_city: "Los Angeles", arrival_city: "Huntsville", airline_id: airline2.id )

      pass1 = Passenger.create!(name: "Beth", age: 19) #1
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

      visit flights_path

      within(".flight-#{flight1.id}") do
        expect(page).to have_content("Flight: #{flight1.number}")

        expect(page).to have_content("Airline: DIA")
        expect(page).to_not have_content("Airline: LAX")

        expect(page).to_not have_content("Flight: #{flight2.number}")
        expect(page).to_not have_content("Flight: #{flight3.number}")

        expect(page).to have_content("#{pass1.name}")
        expect(page).to have_content("#{pass2.name}")

        expect(page).to_not have_content("#{pass3.name}")
        expect(page).to_not have_content("#{pass4.name}")
        expect(page).to_not have_content("#{pass5.name}")
      end

      within(".flight-#{flight2.id}") do
        expect(page).to have_content("Flight: #{flight2.number}")

        expect(page).to have_content("Airline: DIA")
        expect(page).to_not have_content("Airline: LAX")

        expect(page).to_not have_content("Flight: #{flight3.number}")
        expect(page).to_not have_content("Flight: #{flight1.number}")

        expect(page).to have_content("#{pass3.name}")

        expect(page).to_not have_content("#{pass1.name}")
        expect(page).to_not have_content("#{pass2.name}")
        expect(page).to_not have_content("#{pass4.name}")
        expect(page).to_not have_content("#{pass5.name}")
        expect(page).to_not have_content("#{pass6.name}")
      end

      within(".flight-#{flight3.id}") do
        expect(page).to have_content("Flight: #{flight3.number}")

        expect(page).to have_content("Airline: LAX")
        expect(page).to_not have_content("Airline: DIA")

        expect(page).to_not have_content("Flight: #{flight1.number}")
        expect(page).to_not have_content("Flight: #{flight2.number}")

        expect(page).to have_content("#{pass4.name}")
        expect(page).to have_content("#{pass5.name}")
        expect(page).to have_content("#{pass6.name}")

        expect(page).to_not have_content("#{pass1.name}")
        expect(page).to_not have_content("#{pass2.name}")
        expect(page).to_not have_content("#{pass3.name}")
      end
    end
  end

  describe 'User Story 2' do
    it 'can remove a passenger from a flight' do
      airline1 = Airline.create!(name: "DIA")
      airline2 = Airline.create!(name: "LAX")

      flight1 = Flight.create!(number: "3205", date: "02/25/2022", departure_city: "Denver", arrival_city: "Los Angeles", airline_id: airline1.id )
      flight2 = Flight.create!(number: "4505", date: "03/25/2022", departure_city: "Denver", arrival_city: "Huntsville", airline_id: airline1.id )
      flight3 = Flight.create!(number: "5505", date: "03/25/2022", departure_city: "Los Angeles", arrival_city: "Huntsville", airline_id: airline2.id )

      pass1 = Passenger.create!(name: "Beth", age: 19) #1
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

      visit flights_path

      within(".flight-#{flight1.id}") do
        within(".passenger-#{pass1.id}") do
          expect(page).to have_content("Beth")

          passenger_flight = PassengerFlight.where(passenger_id: pass1.id).first
          expect(passenger_flight.flight_id).to eq(flight1.id)

          expect(page).to have_button("Remove")

          click_button "Remove"

          expect(current_path).to eq(flights_path)
          expect(passenger_flight.passenger.flight_id).to eq(nil)
        end
      end

      within(".flight-#{flight2.id}") do
        within(".passenger-#{pass3.id}") do
          expect(page).to have_content("Bill")

          passenger_flight = PassengerFlight.where(passenger_id: pass3.id).first
          expect(passenger_flight.flight_id).to eq(flight2.id)

          expect(page).to have_button("Remove")

          click_button "Remove"

          expect(current_path).to eq(flights_path)
          expect(passenger_flight.passenger.flight_id).to eq(nil)
        end
      end

      within(".flight-#{flight3.id}") do
        within(".passenger-#{pass4.id}") do
          expect(page).to have_content("Joe")

          passenger_flight = PassengerFlight.where(passenger_id: pass4.id).first
          expect(passenger_flight.flight_id).to eq(flight3.id)

          expect(page).to have_button("Remove")

          click_button "Remove"

          expect(current_path).to eq(flights_path)
          expect(passenger_flight.passenger.flight_id).to eq(nil)
        end
      end
    end
  end
end