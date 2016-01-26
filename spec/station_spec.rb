require_relative '../lib/station'

describe Station do
  let(:name) {double :name}
  let(:zone) {double :zone}
  let(:subject) {described_class.new(name, zone)}

  describe '#initialize' do
    it "knows its name" do
      subject.name = "Bank"
      expect(subject.name).to eq "Bank"
    end

    it "knows its zone" do
      subject.zone = 4
      expect(subject.zone).to eq 4      
    end
  end

end
