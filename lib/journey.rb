require_relative 'station'

PENALTY_FAIR = 6
MINIMUM_FARE = 1

class Journey
  attr_reader :in_journey, :trip_history, :current_trip, :station

  def initialize(station = Station.new)
    @station = station
    @in_journey = false
    @trip_history = []
    @current_trip = {}
  end

  def touch_in_process(station, zone)
    unless in_journey?
      @in_journey = true
      set_entry_station(station)
      set_s_zone(zone)
    else
      set_s_zone(zone)
      set_entry_station(station)
      set_exit_station(nil)
      set_e_zone(nil)
    end
  end

  def touch_out_process(station, zone)
    if in_journey?
      @in_journey = false
      set_e_zone(zone)
      set_exit_station(station)
    else
      set_entry_station(nil)
      set_s_zone(nil)
      set_e_zone(zone)
      set_exit_station(station)
    end
  end

  def fare
    return PENALTY_FAIR if trip_history.last.values.include?(nil)
    MINIMUM_FARE
  end

  private

  def set_entry_station(station)
    @station.start = station
  end

  def set_e_zone(zone)
    @station.e_zone = zone
  end

  def set_s_zone(zone)
    @station.s_zone = zone
  end

  def set_exit_station(station)
    @station.ends = station
    create_trip
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

end
