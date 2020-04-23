class Oyster
  attr_reader :balance
  MAX_LIMIT = 90
  FARE = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise "Maximum limit reached!" if balance + amount > MAX_LIMIT
    @balance += amount
  end

  def touch_in
    raise 'Insufficient funds!' if balance < FARE
    @in_use = true
  end

  def touch_out
    deduct(FARE)
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
