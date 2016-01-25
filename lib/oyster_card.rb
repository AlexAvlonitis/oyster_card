MAXIMUM_LIMIT = 90
MINIMUM_LIMIT = 1

class OysterCard
  attr_reader :balance, :journey, :start_from

  def initialize
    @journey = false
    @balance = 0
  end

  def topup(value)
    if exceeds_max_limit(value)
      raise 'balance exceeded'
    else
      add_to_balance(value)
    end
  end

  def touch_in(starting_station = :Aldgate)
    fail "not enough money" if less_than_min_limit
    set_journey_status(true) unless in_journey?
    set_start_of_journey(starting_station)
  end


  def touch_out
    set_journey_status(false) if in_journey?
    deduct
  end

  private

  def exceeds_max_limit(value)
    (@balance + value) > MAXIMUM_LIMIT
  end

  def less_than_min_limit
    balance < MINIMUM_LIMIT
  end

  def set_journey_status(status)
    @journey = status
  end

  def set_start_of_journey(starting_station)
    @start_from = starting_station
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
