require_relative 'station'

PENALTY_FAIR = 6
MINIMUM_FARE = 1

class Journey
  attr_reader :in_journey, :trip_history, :station

  def initialize(station = Station.new)
    @station = station
    @in_journey = false
    @trip_history = []
  end

  def set_in_journey(bool)
    @in_journey = bool
  end

  def fare
    return PENALTY_FAIR if completed?
    MINIMUM_FARE
  end


  def set_start(station, zone)
    @station.start = station
    @station.s_zone = zone
  end

  def set_exit(station, zone)
    @station.ends = station
    @station.e_zone = zone
  end

  def create_trip
    @trip_history << @station.dup
    empty_struct
  end

  def empty_struct
    @station.start = nil
    @station.ends = nil
    @station.s_zone = nil
    @station.e_zone = nil
  end

  def in_journey?
    in_journey
  end

  def completed?
    !!( trip_history.last.values.include?(nil) )
  end

end
