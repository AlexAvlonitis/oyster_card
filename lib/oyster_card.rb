require_relative 'journey'
require_relative 'station'

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
    journey.touch_in_process(station, zone)
  end

  def touch_out(station, zone)
    deduct
    journey.touch_out_process(station, zone)
  end

  private

  def exceeds_max_limit(value)
    (@balance + value) > MAXIMUM_LIMIT
  end

  def less_than_min_limit
    @balance < MINIMUM_LIMIT
  end

  def deduct
    @balance -= MINIMUM_FARE
  end
end
