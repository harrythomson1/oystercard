require 'oystercard'

describe Oystercard do

  let(:station) { double }
  
  it "should have a balance of zero" do
     expect(subject.balance).to eq 0
  end
  
   
  describe "top_up" do
    it "should add money to card " do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end
  


  it "should raise an error if topping up more than £90" do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    expect{ subject.top_up(1) }.to raise_error("exceed maximum top up limit to #{maximum_balance}")
    end
  end

  describe 'in_journey?' do
    it 'initially not in jouney' do
      expect(subject).not_to be_in_journey
    end
  end

    
    describe "touch_in" do
      it "card is in use" do
        subject.top_up(5)
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end

      it "should raise an error if card does not have minimum amount when card touches in" do 
        minimum_balance = Oystercard::MINIMUM_BALANCE
        subject.top_up(minimum_balance)
        expect{subject.touch_in(station)}.to raise_error("Insufficient funds")
      end

      it "returns an entry station" do
        subject.top_up(5)
        expect(subject.touch_in(station)).to eq(station)
      end

      it "records the station at touch in" do
        subject.top_up(5)
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end
    end
  

  describe "touch_out" do
    it "card becomes inactive" do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it "deducts the fare from the card when touch_out" do
      minimum_fare = Oystercard::MINIMUM_FARE
      subject.top_up(5)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{subject.balance}.by(-minimum_fare)
    end

  end

  describe 'journeys' do
    it 'returns an empty list for journeys by default' do
      expect(subject.journeys).to eq []
    end
  end
  
    it 'stores touch in and out stations in one journey' do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(station)
      expect( subject.journeys).to eq [{ entry: station, exit: station }]
    end

    
  
end