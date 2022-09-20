require './Randomizer.rb'

class Die < Randomizer
    attr_accessor :sides, :colour, :num_randomizations

    def initialize(sides, colour)
        @sides = sides
        @colour = colour
        @num_randomizations = 0
    end

    def colour() # returns the colour of the die (does not set it)
        return @colour
    end

    def sides() # returns the number of sides (does not set it)
        return @sides
    end

    def roll() # rolls die and returns self (for method chaining), is a synonym for randomize()
        randomize()
        return self
    end

    def sideup() # returns the result of the last roll, or nil (if not rolled), is a synonym for result()
        @up = result()
        return @up
    end

end
