require_relative '../lib/journey'

describe Journey do
  let(:subject) {described_class.new}

  it { is_expected.to respond_to(:trip_history) }
  it { is_expected.to respond_to(:last_trip) }
end
