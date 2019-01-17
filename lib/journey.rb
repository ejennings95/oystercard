class Journey
  attr_reader :entry, :exit

  def initialize(entry, exit)
    @entry = entry
    @exit = exit
  end

  def complete?
    !@entry.nil? && @exit.nil?
  end

end
