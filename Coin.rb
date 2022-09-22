require './Randomizer.rb'

class Coin < Randomizer
    # all Randomizers have the instance variables: ‘sides’ and ‘up’
    attr_accessor :up, :sides, :denomination, :item, :num_randomizations
    module Denomination
        NICKEL = 0.05
        DIME = 0.10
        QUARTER = 0.25
        LOONIE = 1
        TOONIE = 2
    end

    def initialize(denomination)
        if denomination != Denomination::NICKEL && denomination != Denomination::DIME && denomination != Denomination::QUARTER && denomination != Denomination::LOONIE && denomination != Denomination::TOONIE
            @denomination = nil 
        else
            @denomination = denomination
        end
        @sides = 2 # default for coin
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
