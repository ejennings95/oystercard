require_relative 'journey'

class JourneyLog

attr_reader :journeys

def initialize(journey_class = Journey)
  @journey = journey_class
  @journeys = []
end

def start(entry_station)
  @journeys << create_journey(entry_station, nil)
end

def create_journey(entry_station, exit_station)
  @journey.new(entry_station, exit_station)
end

def end(exit_station)
  in_journey? ?  @journeys.last.exit = exit_station : didnt_touch_in(exit_station)
end

def didnt_touch_in(exit_station)
  @journeys << create_journey(nil, exit_station)
end

def in_journey?
  @journeys == [] ? false : !@journeys.last.complete?
end

end
