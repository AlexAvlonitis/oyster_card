require 'journey'

describe Journey do

let(:station) {double :station, zone: 1}
let(:exit_station) {double :station, zone: 2}
subject(:journey) {Journey.new}

  it 'should have a entry station' do
    expect(journey.start_station(station)).to eq station
  end


  it 'should have an exit station' do
    expect(journey.end_journey(exit_station)).to eq exit_station
  end

  describe 'journey charging' do

    it 'should return a minimum fare' do
      journey.start_station(station)
      journey.end_journey(exit_station)
      expect(journey.fare).to eq Oystercard::MINIMUM_FARE
    end

    it 'should return a penalty fare' do
      journey.start_station(station)
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

  end


end
