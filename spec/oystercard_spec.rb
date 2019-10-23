require "oystercard"
require "journey"

describe Oystercard do
  subject(:card) { Oystercard.new }
  let(:journey) { Journey.new }

  context 'new card' do
    it 'initialise oystercard with balance of 0' do
      expect(card.balance).to eq 0
    end

  end

  context 'with balance' do
    before do
      card.top_up(50)
      journey.touch_in(station, card)
    end

    let(:station){ double :station }

    it 'touch out card reduces balance by minimum fare' do
      expect { journey.touch_out(station, card) }.to change{ card.balance }.by -Journey::MINIMUM_FARE
    end

  end

  describe '#top_up' do

    it 'can top up the balance' do
      expect{  card.top_up 10 }.to change{ card.balance }.by 10
    end

    it 'throws error when trying to top up past limit' do
      expect { card.top_up 100 }.to raise_error(RuntimeError, "top up limit #{Oystercard::LIMIT} reached")
    end

  end

end
