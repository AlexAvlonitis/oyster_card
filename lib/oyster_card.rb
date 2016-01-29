require_relative 'journey'

MAXIMUM_LIMIT = 90
MINIMUM_LIMIT = 1

class OysterCard
  attr_reader :balance, :journey

  def initialize(journey = Journey.new)
    @journey = journey
    @balance = 0
  end

  def topup(value)
    fail 'balance exceeded' if exceeds_max_limit(value)
    @balance += value
  end

  def touch_in(station, zone)
    fail "not enough money" if less_than_min_limit
    unless journey.in_journey
      journey.set_in_journey(true)
      journey.set_start(station, zone)
    else
      journey.set_exit(nil, nil)
      journey.create_trip
      journey.set_start(station, zone)
      deduct
    end
  end

  def touch_out(station, zone)
    if journey.in_journey
      journey.set_in_journey(false)
      journey.set_exit(station, zone)
      journey.create_trip
      deduct
    else
      journey.set_start(nil, nil)
      journey.set_exit(station, zone)
      journey.create_trip
      deduct
    end
  end

  private

  def exceeds_max_limit(value)
    (@balance + value) > MAXIMUM_LIMIT
  end

  def less_than_min_limit
    @balance < MINIMUM_LIMIT
  end

  def deduct
    @balance -= journey.fare
  end

end
