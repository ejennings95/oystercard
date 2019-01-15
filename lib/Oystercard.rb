class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_accessor :balance, :in_use, :entry_station, :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    oystercard_full?(amount)
    @balance += amount
  end

  def in_journey?
    @entry_station.nil? ? false : true
  end

  def touch_in(entry_station)
    insufficient_balance?
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @journeys << { @entry_station => exit_station }
    @entry_station = nil
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
