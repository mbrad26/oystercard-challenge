class Oyster
  attr_reader :balance
  MAX_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum limit reached!" if @balance + amount > MAX_LIMIT
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end
end
