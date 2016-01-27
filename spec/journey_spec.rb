require_relative '../lib/journey'

describe Journey do
  let(:structor) { Station.new }
  let(:subject) { described_class.new(structor) }
  let(:station) { double :station }
  let(:zone) { double :zone }

  it { is_expected.to respond_to(:current_trip) }

  context 'Touching in and out processes' do

    describe '#touch_in_process' do
      before do
        subject.touch_in_process(station, zone)
      end

      it 'sets journey to true' do
        expect(subject.in_journey).to eq true
      end

      it 'sets the starting station' do
        expect(subject.station.start).to eq station
      end

      describe 'if you touch in twice' do
        it 'creates a journey and sets the exit station to nil' do
          subject.touch_in_process(station, zone)
          expect(subject.trip_history.last.ends).to be_nil
        end
      end
    end

    describe '#touch_out_process' do
      before do
        subject.touch_in_process(station, zone)
        subject.touch_out_process(station, zone)
      end

      it "sets journey to false" do
        expect(subject.in_journey).to eq false
      end

      it "creates a trip" do
        expect(subject.trip_history.last.start).to eq station
        expect(subject.trip_history.last.ends).to eq station
      end

      describe 'if you touch out before you touch in' do
        it 'creates a journey and sets the entry station to nil' do
          subject.touch_out_process(station, zone)
          expect(subject.trip_history.last.start).to be nil
        end
      end
    end

  end

end
