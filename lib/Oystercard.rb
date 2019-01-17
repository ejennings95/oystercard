class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
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
    if (@journeys.last[:entry] != nil) && (@journeys.last[:exit] == nil)
      return true
    end
    false
  end

  def touch_in(entry_station)
    @journeys << {entry: nil, exit: nil}
    insufficient_balance?
    @journeys.last[:entry] = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @journeys.last[:exit] = exit_station
  end

private

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
