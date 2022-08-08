class AirlinesController <ApplicationController
  
  def show
    @airline = Airline.find(params[:id])
  end

  private
  def airline_params
    params.permit(:name)
  end

end