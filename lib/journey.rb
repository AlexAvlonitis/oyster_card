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

  def touch_in_process(station, zone)
    unless in_journey?
      @in_journey = true
      set_start(station, zone)
    else
      set_exit(nil, nil)
      create_trip
      set_start(station, zone)
    end
  end

  def touch_out_process(station, zone)
    if in_journey?
      @in_journey = false
      set_exit(station, zone)
      create_trip
    else
      set_start(nil, nil)
      set_exit(station, zone)
      create_trip
    end
  end

  def fare
    penalty_fair_total = 0
    return PENALTY_FAIR if completed?
    MINIMUM_FARE
  end

  private

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
    !!(@trip_history.last.values.include?(nil))
  end

end
