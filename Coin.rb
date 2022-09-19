require './Randomizer.rb'

class Coin < Randomizer
    module Denomination
        NICKEL = 0.05
        DIME = 0.10
        QUARTER = 0.25
        LOONIE = 1
        TOONIE = 2
    end
    attr_accessor :num_randomizations

    def initialize(denomination)
        if denomination != Denomination::NICKEL && denomination != Denomination::DIME && denomination != Denomination::QUARTER && denomination != Denomination::LOONIE && denomination != Denomination::TOONIE
            @denomination = nil 
        else
            @denomination = denomination
        end
        @sides = 2 # default for coin
        @num_randomizations = 0
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

puts "-------"
puts "Coin.rb"
coin = Coin.new 0.25 # Create class and save it in variable
puts coin.denomination
coin.flip # use .randomize for method chaining
puts coin.sideup # should be nil if flip() has not been called before
puts coin.calls # number of times randomize() has been called
puts "After reset"
coin.reset
puts coin.sideup # should be nil
puts "Done"
puts ""
