require 'oystercard'

describe Oystercard do
  let(:first_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe '#balance' do
    it { is_expected.to respond_to(:balance) }

    it 'should have a default new balance of £0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1) }

    it 'should be able to top up the balance' do
      expect { subject.top_up(10) }.to change { subject.balance }.by 10
    end

    it "should not be able to have a balance over £#{Oystercard::MAXIMUM_BALANCE}" do
      subject.top_up(80)
      expect { subject.top_up(11) }.to raise_error "Maximum balanced is £#{Oystercard::MAXIMUM_BALANCE}"
    end
  end

   describe '#touch_in' do
     it 'should start out of the journey' do
       expect(subject.in_journey?).to eq false
     end

     it { is_expected.to respond_to(:touch_in).with(1) }

     it 'should change in_journey attribute to true' do
       subject.top_up(Oystercard::MINIMUM_BALANCE)
       subject.touch_in(:first_station)
       expect(subject.in_journey?).to eq true
     end

     it "should not be able to touch in if balance under £#{Oystercard::MINIMUM_BALANCE}" do
       expect { subject.touch_in(:first_station) }.to raise_error "insufficient funds < #{Oystercard::MINIMUM_BALANCE}"
     end

     it 'should charge the penalty fare if already touched in' do
        subject.top_up(Oystercard::MINIMUM_BALANCE)
        subject.touch_in(:first_station)
        expect {subject.touch_in(:station)}.to change {subject.balance}.by -Oystercard::PENALTY_FARE
     end

   end

   describe '#touch_out' do
     before(:each) do
       @card = subject
       @card.top_up(15)
     end

     it { is_expected.to respond_to(:touch_out).with(1) }

     it 'should change the in journey attribute to false' do
       @card.touch_in(:first_station)
       @card.touch_out(:exit_station)
       expect(@card.in_journey?).to eq false
     end

     it 'should deduct the minimun balance after touch out' do
       @card.touch_in(:first_station)
       expect { @card.touch_out(:exit_station) }.to change { @card.balance }.by(- Oystercard::MINIMUM_BALANCE)
    end

    it 'should deduct penalty are and start new journey if not touched in' do
       expect {@card.touch_out(:station)}.to change {@card.balance}.by -Oystercard::PENALTY_FARE
    end
  end

  describe '#journeys' do
    it 'should have a journey attribute that by default returns an empty array' do
      expect(subject.journeys).to eq []
    end

    it 'should save journey information in journeys attribute' do
      subject.top_up(15)
      subject.touch_in(:first_station)
      subject.touch_out(:exit_station)
      expect(subject.journeys).to include({ entry: :first_station, exit: :exit_station })
    end
  end
end
