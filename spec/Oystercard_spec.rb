require "Oystercard"

describe Oystercard do

  let(:station) { double(:station) }

  describe '#balance' do

    it { is_expected.to respond_to(:balance) }

    it "should have a default new balance of £0" do
      expect(subject.balance).to eq 0
    end

  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1) }

    it "should be able to top up the balance" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "should not be able to have a balance over £90" do
      subject.top_up(80)
      expect { subject.top_up(11) }.to raise_error "Maximum balanced is £#{Oystercard::MAXIMUM_BALANCE}"
    end

  end

  # describe '#deduct' do
  #
  #   it { is_expected.to respond_to(:deduct).with(1) }
  #
  #   it "should be able to deduct an amount from the balance" do
  #     subject.top_up(15)
  #     expect(subject.deduct(5)).to eq 10
  #   end
  #
  #  end

   describe '#touch_in' do

     it "should start out of the journey" do
       expect(subject.in_journey?).to eq false
     end

     it { is_expected.to respond_to(:touch_in).with(1) }

     it "should change the in_use attribute to true" do
       subject.top_up(Oystercard::MINIMUM_BALANCE)
       subject.touch_in(:station)
       expect(subject.in_journey?).to eq true
     end

     it "should not be able to touch in if balance under £1" do
       expect { subject.touch_in(:station) }.to raise_error "insufficient funds < #{Oystercard::MINIMUM_BALANCE}"
     end

     it "should store the given station in an entry_station attribute" do
       subject.top_up(Oystercard::MINIMUM_BALANCE)
       subject.touch_in(:station)
       expect(subject.entry_station).to eq :station
     end

   describe '#touch_out' do

     before(:each) do
       @card = subject
       @card.top_up(15)
     end

     it { is_expected.to respond_to(:touch_out).with(1) }

     it "should change the in_use attribute to false" do
       @card.touch_in(:station)
       @card.touch_out(:station)
       expect(@card.in_journey?).to eq false
     end

     it "should deduct the minimun balance after touch out" do
      @card.touch_in(:station)
      expect { @card.touch_out(:station) }.to change{@card.balance}.by(- Oystercard::MINIMUM_BALANCE)
    end

    it "should change the entry_station attribute back to nil" do
      @card.touch_in(:station)
      @card.touch_out(:station)
      expect(subject.entry_station).to eq nil
    end

    it "should save journey information in journeys attribute" do
      @card.touch_in(:station)
      @card.touch_out(:station)
      expect(subject.journeys).to include({:station => :station})
  end

end

  describe '#journeys' do

    it "should have a journey attribute that by default returns an empty array" do
      expect(subject.journeys).to eq []
    end

  end


  end

end
