
class JourneyLog

  attr_reader :entry_station, :exit_station, :journey_list

  def initialize(journey = Journey.new)
    @journey = journey
    @entry_station = nil
    @exit_station = nil
    @journey_list = {}
  end

  def start_journey(entry_station)
    unless @journey.in_journey?
      @journey.set_in_journey(true)
      @entry_station = entry_station
    else
      set_journey
    end
  end

  def set_exit(exit_station)
    @exit_station = exit_station
  end

  def set_journey
      @journey.set_in_journey(false)
      @journey_list[@entry_station] = @exit_station
  end


end
