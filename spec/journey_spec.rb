require 'journey'
describe Journey do
  let(:station) { double :station}
  let(:station2) {double :station2}

  it "knows if a journey is not complete" do
    expect(subject).to_not be_complete
  end

  # it "has penalty fare by default" do
  #   expect(subject.fare).to eq Journey::PENALTY_FARE
  # end


end
