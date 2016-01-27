require_relative 'station'

PENALTY_FAIR = 6
MINIMUM_FARE = 1

class Journey
  attr_reader :in_journey, :trip_history, :current_trip

  def initialize()
    @in_journey = false
    @trip_history = []
    @current_trip = {}
  end

  def touch_in_process(station)
    unless in_journey?
      @in_journey = true
      set_entry_station(station)
    else
      set_entry_station(station)
      set_exit_station(nil)
    end
  end

  def touch_out_process(station)
    if in_journey?
      @in_journey = false
      set_exit_station(station)
    else
      set_entry_station(nil)
      set_exit_station(station)
    end
  end

  def fare
    return PENALTY_FAIR if trip_history.last.values.include?(nil)
    MINIMUM_FARE
  end

  private

  def set_exit_station(station)
    @current_trip[:end] = station
    create_trip
  end

  def set_entry_station(station)
    @current_trip[:start] = station
  end

  def create_trip
    @trip_history << @current_trip.dup
    @current_trip.clear
  end

  def in_journey?
    in_journey
  end

end
