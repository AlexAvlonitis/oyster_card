require_relative 'journey'
require_relative 'station'

MAXIMUM_LIMIT = 90
MINIMUM_LIMIT = 1
MINIMUM_FARE = 1

class OysterCard
  attr_reader :balance, :journey

  def initialize(journey = Journey.new)
    @journey = journey
    @balance = 0
  end

  def topup(value)
    fail 'balance exceeded' if exceeds_max_limit(value)
    add_to_balance(value)
  end

  def touch_in(station)
    fail "not enough money" if less_than_min_limit
    unless journey.in_journey?
      journey.set_journey_status(true)
      journey.set_entry_station(station)
    else
      penalise
    end
  end

  def touch_out(station)
    if journey.in_journey?
      journey.set_journey_status(false)
      deduct
      journey.set_exit_station(station)
    else
      journey.fare
    end
  end

  private

  def penalise
    @balance -= journey.fare
    journey.set_exit_station(nil)
  end

  def exceeds_max_limit(value)
    (@balance + value) > MAXIMUM_LIMIT
  end

  def add_to_balance(value)
    @balance += value
  end

  def less_than_min_limit
    @balance < MINIMUM_LIMIT
  end

  def deduct
    @balance -= MINIMUM_FARE
  end
end
