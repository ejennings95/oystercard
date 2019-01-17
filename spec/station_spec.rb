require 'station'

describe Station do

  it 'should it should return the name of the station' do
    station = Station.new("bank", 1)
    expect(station.name).to  eq "bank"
  end

  it 'should it should return the zone of the station' do
    station = Station.new("bank", 1)
    expect(station.zone).to  eq 1
  end

end
