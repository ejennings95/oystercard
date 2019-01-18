class Station

  def initialize(stations = {
    ealing_broadway: 4,
    aldgate_east: 1,
    bank: 1
  })
    @stations = stations
  end

  def zone?(station)
    return 0 if station == nil
    @stations[station.to_sym]
  end

end
