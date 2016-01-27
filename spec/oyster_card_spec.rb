require_relative '../lib/oyster_card'
require_relative '../lib/journey'

describe OysterCard do
  let(:journey) { Journey.new }
  subject(:subject) {described_class.new(journey)}
  let(:station) {double :station}
  let(:zone) {double :zone}


  describe 'Journeys' do

    before do
      subject.topup(10)
      subject.touch_in(station, zone)
    end

    it "returns empty trips array when a new card is initialized" do
      expect(subject.journey.trip_history).to be_empty
    end

    # context "Penalty for incomplete journeys" do
    #   describe "#penalise" do
    #     it "deducts £6 if you touch in twice" do
    #       expect {subject.touch_in(station)}.to change(subject, :balance).by(-6)
    #     end
    #
    #     it "deducts £6 if you touch out before you touch in" do
    #       subject.touch_out(station)
    #       expect {subject.touch_out(station)}.to change(subject, :balance).by(-6)
    #     end
    #   end
    #
    # end

  end

  describe 'Balance' do

    it 'starts at 0' do
      subject.balance
      expect(subject.balance).to eq 0
    end

    it "can't touch in if it has below the minimum amount" do
      expect {subject.touch_in(station, zone)}.to raise_error("not enough money")
    end

    describe 'Adding to the balance' do
      it 'tops up balance' do
        expect {subject.topup(10)}.to change {subject.balance}.by(10)
      end

      it "doesn't allow you to exceed limit of £90" do
        expect {subject.topup(100)}.to raise_error 'balance exceeded'
      end
    end

    describe 'Deducting from the balance' do
      it 'deducts minimum fare from balance when touch out' do
        subject.topup(10)
        subject.touch_in(station, zone)
        expect {subject.touch_out(station, zone)}.to change(subject, :balance).by(-1)
      end
    end

  end
end
