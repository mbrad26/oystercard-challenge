class Oyster
  attr_reader :balance, :entry_station, :journeys, :exit_station
  MAX_LIMIT = 90
  FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = Array.new
  end

  def top_up(amount)
    raise "Maximum limit reached!" if balance + amount > MAX_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Insufficient funds!' if balance < FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(FARE)
    @exit_station = exit_station
    @journeys << {entry_station: entry_station, exit_station: exit_station}
    @entry_station = nil
  end

  def in_journey?
    @entry_station
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end
