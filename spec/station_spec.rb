require_relative '../lib/station'

describe Station do
  let(:start) {double :start}
  let(:ends) {double :ends}
  let(:e_zone) {double :e_zone}
  let(:s_zone) {double :s_zone}
  let(:subject) {described_class.new(start, ends, e_zone, s_zone)}

  describe '#initialize' do
    it "knows its start station" do
      subject.start = "Bank"
      expect(subject.start).to eq "Bank"
    end

    it "knows its end station" do
      subject.ends = "Pinner"
      expect(subject.ends).to eq "Pinner"
    end

    it "knows its entry zone" do
      subject.e_zone = 4
      expect(subject.e_zone).to eq 4
    end

    it "knows its exit zone" do
      subject.s_zone = 2
      expect(subject.s_zone).to eq 2
    end
  end

end
