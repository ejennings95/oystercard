class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_accessor :balance, :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    oystercard_full?(amount)
    @balance += amount
  end

  def in_journey?
    @in_use
  end

  def touch_in
    insufficient_balance?
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @in_use = false
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
