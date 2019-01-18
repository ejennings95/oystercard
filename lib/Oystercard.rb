require_relative 'station'
require_relative 'journey'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY_FARE = 6
  attr_reader :balance, :journeys

  def initialize(journey_class = Journey)
    @balance = 0
    @journeys = []
    @journey = journey_class
  end


  def top_up(amount)
    oystercard_full?(amount)
    @balance += amount
  end

  def in_journey?
    @journeys == [] ? false : !@journeys.last.complete?
  end

  def touch_in(entry_station)
    insufficient_balance?
    fare if in_journey?
    start_journey(entry_station)
  end

  def touch_out(exit_station)
    in_journey? ?  end_journey(exit_station) : didnt_touch_in(exit_station)
    fare
  end

private

  def didnt_touch_in(exit_station)
    @journeys << create_journey(nil, exit_station)
  end

  def end_journey(exit_station)
    @journeys.last.finish(exit_station)
  end

  def start_journey(entry_station)
    @journeys << create_journey(entry_station, nil)
  end

  def fare
    deduct(@journeys.last.fare)
  end

  def deduct(amount)
    @balance -= amount
  end

  def create_journey(entry_station, exit_station)
    @journey.new(entry_station, exit_station)
  end

  def oystercard_full?(amount)
    raise "Maximum balanced is £#{MAXIMUM_BALANCE}" if amount + @balance > MAXIMUM_BALANCE
  end

  def insufficient_balance?
    raise "insufficient funds < #{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
  end

end
