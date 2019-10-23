require "oystercard"

class Journey

MINIMUM_BALANCE = 1

attr_reader :entry_station, :exit_station, :journeys

  def initialize
    @journeys = []
  end

  def in_journey?
    return false if @entry_station == nil

    return true
  end

  def touch_in(station, card)
    raise "Balance too low to touch in. Minimum balance is £#{MINIMUM_BALANCE}" if card.balance < MINIMUM_BALANCE

    @entry_station = station
  end

  def touch_out(station, card)
    card.deduct(1)
    @journeys.push({entry: @entry_station, exit: station})
    @entry_station = nil
  end

end
