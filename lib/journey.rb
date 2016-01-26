class Journey
  attr_reader :in_journey, :trip_history, :last_trip

  def initialize
    @in_journey = false
    @trip_history = []
    @last_trip = {}
  end

  def set_exit_station(station)
    @last_trip[:end] = station
    create_trip
  end

  def create_trip
    @trip_history << @last_trip
  end

  def set_journey_status(status)
    @in_journey = status
  end

  def set_entry_station(station)
    @last_trip[:start] =  station
  end

  def in_journey?
    in_journey
  end

end
