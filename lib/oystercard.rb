class Oystercard
    attr_reader :balance,  :entry_station, :journeys
    MAXIMUM_BALANCE = 90
    MINIMUM_BALANCE = 1
    INITIAL_BALANCE = 0
    MINIMUM_FARE = 1

    def initialize
        @balance = INITIAL_BALANCE
        @entry_station = nil
        @journeys = []
    end
    
    def top_up(money)
        raise "exceed maximum top up limit to #{MAXIMUM_BALANCE}" if money + balance > MAXIMUM_BALANCE
        @balance += money
    end
       
    def in_journey?
        @entry_station ? true : false
    end

    def touch_in(entry_station)
        raise "Insufficient funds" if balance <= MINIMUM_BALANCE
        @entry_station = entry_station


        #@journeys.push({entry: entry_station, exit: nil])
    end

    def touch_out(exit_station)
        deduct
        @journeys.push({entry: @entry_station, exit: exit_station})
        @entry_station = nil
    end

    private
     
    def deduct(money = MINIMUM_FARE)
        @balance -= money
    end
end

