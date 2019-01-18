require_relative 'station'

class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  attr_accessor :entry, :exit

  def initialize(entry = nil, exit = nil)
    @entry = entry
    @exit = exit
  end

  def complete?
    !@entry.nil? && !@exit.nil?
  end

  def new_journey?
    @entry.nil? && @exit.nil?
  end

 def fare
   return MINIMUM_FARE if zone_boundaries_crossed == 0
   (new_journey?) || (complete?) ? (zone_boundaries_crossed * MINIMUM_FARE) : PENALTY_FARE
 end

 private

 def zone_boundaries_crossed
   (Station.new.zone?(@entry) - Station.new.zone?(@exit)) * -1
 end

end
