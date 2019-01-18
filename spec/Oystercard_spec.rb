require 'oystercard'
require 'journey'

describe Oystercard do
  let(:first_station) { double(:station) }
  let(:exit_station) { double(:station) }

    it { is_expected.to respond_to(:balance) }

    it 'should have a default new balance of £0' do
      expect(subject.balance).to eq 0
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


     it { is_expected.to respond_to(:touch_in).with(1) }

     it "should not be able to touch in if balance under £#{Oystercard::MINIMUM_BALANCE}" do
       expect { subject.touch_in(:first_station) }.to raise_error "insufficient funds < #{Oystercard::MINIMUM_BALANCE}"
     end

     it 'should charge the penalty fare if already touched in' do
        subject.top_up(Oystercard::MAXIMUM_BALANCE)
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

     it 'should deduct the minimun balance after touch out' do
       @card.touch_in(:first_station)
       expect { @card.touch_out(:exit_station) }.to change { @card.balance }.by(- Oystercard::MINIMUM_BALANCE)
     end

      it 'should deduct penalty are and start new journey if not touched in' do
         expect {@card.touch_out(:station)}.to change {@card.balance}.by -Oystercard::PENALTY_FARE
      end
    end
end
