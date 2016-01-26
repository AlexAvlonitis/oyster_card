MAXIMUM_LIMIT = 90
MINIMUM_LIMIT = 1
MINIMUM_FARE = 1

class OysterCard
  attr_reader :balance, :journey, :trip_history, :last_trip

  def initialize
    @journey = false
    @balance = 0
    @trip_history = []
    @last_trip= {}
  end

  def topup(value)
    fail 'balance exceeded' if exceeds_max_limit(value)
    add_to_balance(value)
  end

  def touch_in(station)
    fail "not enough money" if less_than_min_limit
    unless in_journey?
      set_journey_status(true)
      set_entry_station(station)
    else
      fail "can't touch in twice on the same journey"
    end
  end

  def touch_out(station)
    if in_journey?
      set_journey_status(false)
      deduct
      set_exit_station(station)
    else
      fail "can't touch out if you haven't touched in first"
    end
  end

  private

  def set_exit_station(station)
    @last_trip[:end] = station
    create_trip
  end

  def create_trip
    @trip_history << @last_trip
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
    @last_trip[:start] =  station
  end

  def in_journey?
    journey
  end

  def add_to_balance(value)
    @balance += value
  end

  def deduct
    @balance -= MINIMUM_FARE
  end
end
