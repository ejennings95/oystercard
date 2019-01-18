require 'journey'
describe Journey do
  let(:station) { double :station}
  let(:station2) {double :station2}

  it "knows if a journey is not complete" do
    expect(subject).to_not be_complete
  end
  
  it "returns new journey if entry and exit stations are not given" do
    expect(subject).to be_new_journey
  end

  context "complete journey" do

    it "calculates minimum fare" do
      journey = described_class.new(station, station2)
      expect(journey.fare).to eq 1
    end
  end

  context "incomplete journey" do
    it "with no touch in calculates penalty fare when trying to finish" do
      journey = described_class.new(nil, station)
      expect(journey.fare).to eq 6
    end
  end
end
