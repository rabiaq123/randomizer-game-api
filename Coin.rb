require './Randomizer.rb'

class Coin < Randomizer
    # all Randomizers have the instance variables: ‘sides’ and ‘up’
    attr_accessor :up, :sides, :denomination, :item, :num_randomizations
    DENOMINATION = {
        nickel: 0.05,
        dime: 0.10,
        quarter: 0.25,
        loonie: 1,
        toonie: 2
    }

    def initialize(denomination)
        if denomination != DENOMINATION[:nickel] && denomination != DENOMINATION[:dime] && denomination != DENOMINATION[:quarter] && denomination != DENOMINATION[:loonie] && denomination != DENOMINATION[:toonie]
            @denomination = nil 
        else
            @denomination = denomination
        end
        @sides = 2 # default for coin
        @up = nil
        @num_randomizations = 0
        @item = :coin
    end

    def denomination() # returns the denomination of the coin (does not set it)
        return @denomination
    end

    def flip() # flips the coin, returns self, is a synonym for randomize()
        randomize()
        return self
    end

    def sideup() # returns :H or :T (the result of the last flip) or nil (if no flips yet done), is a synonym for result()
        @up = result()
        if @up == 1
            return :H
        elsif @up == 2
            return :T
        end
    end
end
