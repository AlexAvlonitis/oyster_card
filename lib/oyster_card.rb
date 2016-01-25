MAXIMUM_LIMIT = 90
MINIMUM_LIMIT = 1

class OysterCard
  attr_reader :balance, :journey, :entry_station, :exit_station, :trip

  def initialize
    @journey = false
    @balance = 0
    @trip = []
  end

  def topup(value)
    if exceeds_max_limit(value)
      fail 'balance exceeded'
    else
      add_to_balance(value)
    end
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
    create_trip
  end

  private

  def create_trip
    @trip << [{start: @entry_station}, {end: @exit_station}]
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
    @entry_station = station
  end

  def set_exit_station(station)
    @exit_station = station
  end

  def in_journey?
    @journey
  end

  def add_to_balance(value)
    @balance += value
  end

  def deduct
    @balance -= MINIMUM_LIMIT
  end
end
