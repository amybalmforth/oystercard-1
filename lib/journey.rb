require "oystercard"

class Journey

MINIMUM_BALANCE = 1
MINIMUM_FARE = 1
PENALTY_FARE = 6

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
    @exit_station = station
    @journeys.push({entry: @entry_station, exit: @exit_station})
    fare(card)
  end

  def fare(card)
    if @entry_station == nil
      journey_fare = PENALTY_FARE
    else
      journey_fare = MINIMUM_FARE
    end
    journey_fare
    transaction(card)
  end

  def transaction(card)
    card.deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = nil
  end

end
