class FlightsController < ApplicationController
  def index
    match_flights_and_airports
  end

  def new
    @flight = Flight.new
  end

  def create
    flight = Flight.create flight_params
    if flight.save
      redirect_to flights_path
    else
      render :new
    end
  end

  def search
    @flights = Flight.all
    @departure_airports = DepartureAirport.all
    @arrival_airports = ArrivalAirport.all
  end

  def results
    match_flights_and_airports
    if params[:departure_airport].present?
      @desired_departure_airport = DepartureAirport.find params[:departure_airport]
    end
    if params[:arrival_airport].present?
      @desired_arrival_airport = ArrivalAirport.find params[:arrival_airport]
    end
    if params[:depart_time].present?
      @desired_date = params[:depart_time]
    end
  end

  def book
    flight = Flight.find params[:id]
    @current_user.flights.push(flight) unless @current_user.flights.include?(flight)
    redirect_to user_path(@current_user.id)
  end

  def cancel
    flight = Flight.find params[:id]
    @current_user.flights.delete(flight) if @current_user.flights.include?(flight)
    redirect_to user_path(@current_user.id)
  end

  def show
    @flight = Flight.find params[:id]
    @departure_airport = DepartureAirport.find @flight.departure_airport_id
    @arrival_airport = ArrivalAirport.find @flight.arrival_airport_id
  end

  def update
    flight = Flight.find params[:id]
    flight.update flight_params
    redirect_to flight_path(flight.id)
  end

  def destroy
    flight = Flight.find params[:id]
    flight.destroy
    redirect_to flights_path
  end

  private
  def flight_params
    params.require(:flight).permit(:code, :depart_time, :seats, :departure_airport_id, :arrival_airport_id)
  end

  def match_flights_and_airports
    @flights = Flight.all
    @departure_airports = []
    @arrival_airports = []
    @flights.each_with_index do |flight, index|
      @departure_airports[index] = DepartureAirport.find @flights[index].departure_airport_id
    end
    @flights.each_with_index do |flight, index|
      @arrival_airports[index] = ArrivalAirport.find @flights[index].arrival_airport_id
    end
  end
end
