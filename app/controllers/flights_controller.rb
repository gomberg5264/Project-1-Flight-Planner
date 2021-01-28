class FlightsController < ApplicationController
  before_action :check_for_admin, only: [:new, :create, :update, :destroy]
  before_action :check_for_login

  def index
    match_flights_and_airports
  end

  def new
    @flight = Flight.new
  end

  def create
    # Collects the departure and arrival airports
    departure_airport = DepartureAirport.find flight_params[:departure_airport_id]
    arrival_airport = ArrivalAirport.find flight_params[:arrival_airport_id]
    # This conditional checks if the depature and arrival airports are in the same city
    unless departure_airport.city == arrival_airport.city
      # Creates a new flight
      flight = Flight.create flight_params
      if flight.save
        redirect_to flights_path
      else
        # Reloads the page in case of a failed submission
        render :new
      end
    else
      # Reloads the page if the departure and arrival airports are in the same city
      flash[:error] = "Error: Departure And Arrival Airports Can't Match"
      redirect_to new_flight_path
    end
  end

  def search
    # Collects the departure and arrival airports so they can be used in the selects
    @departure_airports = DepartureAirport.all
    @arrival_airports = ArrivalAirport.all
  end

  def results
    match_flights_and_airports
    # Checks if the user has selected a departure airport
    if params[:departure_airport].present?
      @desired_departure_airport = DepartureAirport.find params[:departure_airport]
    end
      # Checks if the user has selected an arrival airport
    if params[:arrival_airport].present?
      @desired_arrival_airport = ArrivalAirport.find params[:arrival_airport]
    end
    # Check for matching departure and arrival airports and return to search page if they match
    if params[:departure_airport].present? && params[:arrival_airport].present?
      if @desired_departure_airport.name == @desired_arrival_airport.name
        flash[:error] = "Airports Can't Match"
        redirect_to search_flights_path
        #TODO: Include a pop up stating that the airports can't match
      end
    end
    # Checks if the user has selected a date
    if params[:depart_time].present?
      @desired_date = params[:depart_time]
    end
  end

  def book
    flight = Flight.find params[:id]
    # Checks if a user hasn't already booked a flight and if there are seats available on the flight
    unless @current_user.flights.include?(flight) || flight.seats < 1
      # Adds a booking
      @current_user.flights.push(flight)
      # Reduces the available seat count after a booking
      flight.seats-=1
      flight.save
      redirect_to user_path(@current_user.id)
    else
      redirect_to search_flights_path
      # TODO include pop-ups warning about flights being already booked or full
    end
  end

  def cancel
    flight = Flight.find params[:id]
    if @current_user.flights.include?(flight)
      flash[:error] = "Deleting Flight"
      # Removes a booking
      @current_user.flights.delete(flight)
      # Increases the available seat count after a booking is cancelled
      flight.seats+=1
      flight.save
    end
    redirect_to user_path(@current_user.id)
  end

  def show
    @flight = Flight.find params[:id]
    # Collect the departure and arrival airports
    @departure_airport = DepartureAirport.find @flight.departure_airport_id
    @arrival_airport = ArrivalAirport.find @flight.arrival_airport_id
    # Collect the airports' coordinates
    start_coordinates = Geokit::LatLng.new(@departure_airport.latitude, @departure_airport.longitude)
    target_coordinates = "#{@arrival_airport.latitude}, #{@arrival_airport.longitude}"
    # Use the geokit gem to find the distance
    distance = start_coordinates.distance_to(target_coordinates)
    plane_speed = 583 # The cruising speed of a Boeing 737 in miles
    # The travel time is calculated by dividing the distance by plane speed and adding 30 minutes to account for delays
    travel_time = (distance / plane_speed) + 0.5
    # The added (or lost) time from converting time zones is calculated and stored as timezone_change
    timezone_change = @arrival_airport.timezone_offset - @departure_airport.timezone_offset
    # The travel time and the timezone_change are added together, than multipled by 3600 to convert from hours into seconds
    @arrival_time = @flight.depart_time + ((travel_time + timezone_change) * 3600)
  end

  def update
    flight = Flight.find params[:id]
    departure_airport = DepartureAirport.find flight_params[:departure_airport_id]
    arrival_airport = ArrivalAirport.find flight_params[:arrival_airport_id]
    # This conditional checks if the depature and arrival airports are in the same city
    unless departure_airport.city == arrival_airport.city
      flight.update flight_params
    else
      flash[:error] = "Airports Can't Match"
    end
    redirect_to flight_path(flight.id)
  end

  def destroy
    flight = Flight.find params[:id]
    flash[:error] = "Deleting Flight"
    flight.destroy
    redirect_to flights_path
  end

  private
  def flight_params
    params.require(:flight).permit(:code, :depart_time, :seats, :departure_airport_id, :arrival_airport_id)
  end

  def match_flights_and_airports
    # Sorts the flights by departure time
    @flights = Flight.all.sort_by { |flight| flight.depart_time}
    # Create arrays for the depature and arrival airports
    @departure_airports = []
    @arrival_airports = []
    @flights.each_with_index do |flight, index|
      # Match departure airports with their flights
      @departure_airports[index] = DepartureAirport.find @flights[index].departure_airport_id
    end
    @flights.each_with_index do |flight, index|
      # Match arrival airports with their flights
      @arrival_airports[index] = ArrivalAirport.find @flights[index].arrival_airport_id
    end
  end
end
