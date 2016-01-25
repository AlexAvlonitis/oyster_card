require_relative '../lib/oyster_card.rb'

describe OysterCard do

subject(:OysterCard) {described_class.new}


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

      it 'doesn\'t allow you to exceed limit of £90' do
        expect {subject.topup(100)}.to raise_error 'balance exceeded'
      end
    end

    context 'Deducting from the balance' do
      it 'deducts minimum fare from balance when touch out' do
        subject.topup(10)
        expect {subject.touch_out}.to change(subject, :balance).from(10).to(9)
      end
    end

    describe 'touch in' do
      before do
        allow(subject).to receive(:balance).and_return(10)
      end
      it 'touch in sets journey to true' do
        subject.touch_in
        expect(subject.journey).to eq true
      end

      it 'sets the starting station' do
        expect {subject.touch_in("Aldgate")}.to change(subject, :start_from)
      end
    end

    describe 'touch out' do
      it "touch out sets journey to false" do
        subject.touch_out
        expect(subject.journey).to eq false
      end
    end

  end
end
