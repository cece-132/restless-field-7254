class PassengerFlightsController < ApplicationController
  
  def update
    @passenger_flight = PassengerFlight.where(passenger_id: params[:id]).first    
    @passenger_flight.update(flight_id: params[:flight_id])
    redirect_to flights_path
    flash[:success] = "#{@passenger_flight.passenger.name} has been removed from flight"
  end
end