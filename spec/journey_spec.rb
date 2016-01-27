require_relative '../lib/journey'

describe Journey do
  let(:subject) { described_class.new }
  let(:station) { double :station }

  it { is_expected.to respond_to(:trip_history) }
  it { is_expected.to respond_to(:current_trip) }
  it { is_expected.to respond_to(:in_journey) }


  context 'Touching in and out processes' do

    describe '#touch_in_process' do
      before do
        subject.touch_in_process(station)
      end

      it 'sets journey to true' do
        expect(subject.in_journey).to eq true
      end

      it 'sets the starting station' do
        expect(subject.current_trip).to match({start: station})
      end

      describe 'if you touch in twice' do
        it 'creates a journey and sets the exit station to nil' do
          subject.touch_in_process(station)
          expect(subject.trip_history).to include({start: station, end: nil})
        end
      end
    end

    describe '#touch_out_process' do
      before do
        subject.touch_in_process(station)
        subject.touch_out_process(station)
      end

      it "sets journey to false" do
        expect(subject.in_journey).to eq false
      end

      it "creates a trip" do
        expect(subject.trip_history).to include({start: station, end: station})
      end

      describe 'if you touch out before you touch in' do
        it 'creates a journey and sets the entry station to nil' do
          subject.touch_out_process(station)
          expect(subject.trip_history).to include({start: nil, end: station})
        end
      end
    end

  end

end
