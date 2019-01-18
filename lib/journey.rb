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
     (new_journey?) || (complete?) ? MINIMUM_FARE : PENALTY_FARE
   end
end
