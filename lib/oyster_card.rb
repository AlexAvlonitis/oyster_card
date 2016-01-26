MAXIMUM_LIMIT = 90
MINIMUM_LIMIT = 1

class OysterCard
  attr_reader :balance, :journey, :trip_history, :current_trip

  def initialize
    @journey = false
    @balance = 0
    @trip_history = []
    @current_trip= {}
  end

  def topup(value)
    fail 'balance exceeded' if exceeds_max_limit(value)
    add_to_balance(value)
  end

  def touch_in(station = "")
    fail "not enough money" if less_than_min_limit
    set_journey_status(true) unless in_journey?
    set_entry_station(station)
  end

  def touch_out(station = "")
    set_journey_status(false) if in_journey?
    deduct
    set_exit_station(station)
  end

  private

  def set_exit_station(station)
    @current_trip[:end] = station
    create_trip
  end

  def create_trip
    @trip_history << @current_trip
  end

  def exceeds_max_limit(value)
    (@balance + value) > MAXIMUM_LIMIT
  end

  def less_than_min_limit
    @balance < MINIMUM_LIMIT
  end

  def set_journey_status(status)
    @journey = status
  end

  def set_entry_station(station)
    @current_trip[:start] =  station
  end

  def in_journey?
    journey
  end

  def add_to_balance(value)
    @balance += value
  end

  def deduct
    @balance -= MINIMUM_LIMIT
  end
end
