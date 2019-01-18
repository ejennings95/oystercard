require 'journey'
describe Journey do
  let(:station) { double :station}
  let(:station2) {double :station2}

  it "knows if a journey is not complete" do
    expect(subject).to_not be_complete
  end

  it "returns itself when exiting a journey" do
    expect(subject.finish(station2)).to eq(subject)
  end

  it "returns new journey if entry and exit stations are not given" do
    expect(subject).to be_new_journey
  end

  context "complete journey" do
    before do
      subject.entry = station
      subject.finish(station2)
    end

    it "calculates minimum fare" do
      expect(subject.fare).to eq 1
    end 
  end
  
  context "incomplete journey" do
    it "with no touch in calculates penalty fare when trying to finish" do
      subject.finish(station)
      expect(subject.fare).to eq 6
    end
  end
end
