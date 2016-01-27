require_relative 'station'
require_relative 'journey_log'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey_log
  BALANCE_MAX = 90


  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
  end

  def top_up(value)
    raise "Top-up exceeds maximum limit of #{BALANCE_MAX}" if (@balance + value) > BALANCE_MAX
    @balance += value
  end

  def touch_in(entry_station)
    raise 'Please top up your card.' if @balance < Journey::FARE_MIN
    @journey_log.start_journey(entry_station)
  end

  def touch_out(exit_station)
    deduct(Journey::FARE_MIN)
    @journey_log.set_exit(exit_station)
    @journey_log.set_journey
  end


  private

  def deduct(value)
    @balance -= value
  end

end
