class FlightsController < ApplicationController
  
  def index
    @flights = Flight.all
  end

  def update
    
  end

  private
  def flight_params
    params.permit(:number, 
                  :date, 
                  :departure_city, 
                  :arrival_city, 
                  :arrival_city
                )
  end
end