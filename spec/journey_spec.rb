require "journey"

describe Journey do

  let(:journey) { Journey.new }
  let(:card) { Oystercard.new }

  context "creating a journey history" do

    let(:entry_station){ double :entry_station }
    let(:exit_station){ double :exit_station }

    before do
      card.top_up(50)
    end

    it 'checks for empty journey history' do
      expect(journey.journeys).to be_empty
    end

    it 'assigning the entry station' do
      journey.touch_in(entry_station, card)
      expect(journey.entry_station).to eq entry_station
    end

    it 'forgets entry station' do
      journey.touch_in(entry_station, card)
      journey.touch_out(exit_station, card)
      expect(journey.entry_station).to eq nil
    end

    it 'checks for journey hash' do
      expect(journey.journeys).to be_a(Array)
    end

    it 'creates journey record' do
      history = { entry: entry_station, exit: exit_station }
      journey.touch_in(entry_station, card)
      journey.touch_out(exit_station, card)
      expect(journey.journeys).to include(history)
    end

  end

  context 'without balance' do

    let(:station){ double :station }

    it 'check minimum balance on touch in' do
      expect { journey.touch_in(station, card) }.to raise_error("Balance too low to touch in. Minimum balance is £#{Journey::MINIMUM_BALANCE}")
    end

  end

  context 'calculating fare' do

    let(:station){ double :station }

    before do
      card.top_up(50)
    end

      it 'returns the minimum fare' do
        journey.touch_in(station, card)
        journey.touch_out(station, card)
        expect(journey.fare(card)).to eq(Journey::MINIMUM_FARE)
      end

      it 'returns the penalty fare if no entry station' do
        journey.touch_out(station, card)
        expect(journey.fare(card)).to eq(Journey::PENALTY_FARE)
      end


  end


end
