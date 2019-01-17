require_relative 'station'
require_relative 'journey'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY_FARE = 6
  attr_reader :balance, :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    oystercard_full?(amount)
    @balance += amount
  end

  def in_journey?
    if @journeys == []
      return false
    end
      Journey.new(@journeys.last[:entry], @journeys.last[:exit]).complete?
    end

  def touch_in(entry_station)
    insufficient_balance?
    if in_journey?
      penalty_fare
      start_journey(entry_station)
    else
      start_journey(entry_station)
    end
  end

  def touch_out(exit_station)
    if in_journey?
      deduct(MINIMUM_BALANCE)
      end_journey(exit_station)
    else
      penalty_fare
      @journeys << {entry: nil, exit: exit_station}
    end
  end

private

  def end_journey(exit_station)
    @journeys.last[:exit] = exit_station
  end

  def start_journey(entry_station)
    @journeys << {entry: entry_station, exit: nil}
  end

  def penalty_fare
    deduct(PENALTY_FARE)
  end

  def deduct(amount)
    @balance -= amount
  end

  def oystercard_full?(amount)
    raise "Maximum balanced is £#{MAXIMUM_BALANCE}" if amount + @balance > MAXIMUM_BALANCE
  end

  def insufficient_balance?
    raise "insufficient funds < #{MINIMUM_BALANCE}" if @balance < MINIMUM_BALANCE
  end

end
