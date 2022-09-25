require './Randomizer.rb'

class Coin < Randomizer
    # all Randomizers have the instance variables: ‘sides’ and ‘up’
    attr_accessor :up, :sides, :denomination, :item, :num_randomizations
    DENOMINATION = {
        0.05 => 0.05,
        0.10 => 0.10,
        0.25 => 0.25,
        1 => 1,
        2 => 2,
    }

    def initialize(denomination)
        if DENOMINATION.has_key?(denomination)
            @denomination = denomination
        else
            @denomination = nil 
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
        return result()
    end
end
