require_relative '../lib/journey'

describe Journey do
  let(:subject) { described_class.new }
  let(:station) { double :station }

  it { is_expected.to respond_to(:trip_history) }
  it { is_expected.to respond_to(:last_trip) }
  it { is_expected.to respond_to(:in_journey) }

end
