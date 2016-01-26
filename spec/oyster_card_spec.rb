require_relative '../lib/oyster_card.rb'

describe OysterCard do
  subject(:OysterCard) {described_class.new}

  describe 'Journeys' do
    let(:station) {double :station}

    before do
      subject.topup(10)
      subject.touch_in(station)
    end

    it "empty trips array when a new card is initialized" do
      expect(subject.trip_history).to be_empty
    end

    describe '#touch_in' do
      context 'when touching in' do
        it 'sets journey to true' do
          expect(subject.journey).to eq true
        end

        it 'sets the starting station' do
          expect(subject.current_trip).to match({start: station})
        end
      end
    end

    describe '#touch_out' do
      context 'when touching out' do
        before do
          subject.touch_out(station)
        end
        it "sets journey to false" do
          expect(subject.journey).to eq false
        end

        it "creates a trip" do
          expect(subject.trip_history).to include({start: station, end: station})
        end
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
