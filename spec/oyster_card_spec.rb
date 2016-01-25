require_relative '../lib/oyster_card.rb'

describe OysterCard do
  subject(:OysterCard) {described_class.new}

  context 'Journeys' do
    let(:station) {double :station}

    before do
      subject.topup(10)
    end

    it "empty trips when new card is initialized" do
      expect(subject.trip).to be_empty
    end

    describe 'touch in' do
      it 'touch in sets journey to true' do
        subject.touch_in
        expect(subject.journey).to eq true
      end

      it 'sets the starting station' do
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end
    end

    describe 'touch out' do
      it "touch out sets journey to false" do
        subject.touch_out
        expect(subject.journey).to eq false
      end

      it "creates a trip" do
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject.trip).to eq [[{start: station}, {end: station}]]
      end
    end

  end

  describe 'Balance' do
    it 'balance starts at 0' do
      subject.balance
      expect(subject.balance).to eq 0
    end

    it 'above minimum amount' do
      expect {subject.touch_in}.to raise_error("not enough money")
    end

    context 'Adding to the balance' do
      it 'top up balance' do
        expect {subject.topup(10)}.to change {subject.balance}.by(10)
      end

      it "doesn't allow you to exceed limit of £90" do
        expect {subject.topup(100)}.to raise_error 'balance exceeded'
      end
    end

    context 'Deducting from the balance' do
      it 'deducts minimum fare from balance when touch out' do
        subject.topup(10)
        expect {subject.touch_out}.to change(subject, :balance).from(10).to(9)
      end
    end
  end
end
