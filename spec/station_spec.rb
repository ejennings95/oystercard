require 'station'

describe Station do

  subject { described_class.new("bank", 1) }

  it 'should it should return the name of the station' do
    expect(subject.name).to eq "bank"
  end

  it 'should it should return the zone of the station' do
    expect(subject.zone).to eq 1
  end

end
