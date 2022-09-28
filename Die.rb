require './Randomizer.rb'

class Die < Randomizer
    # all Randomizers have the instance variables 'sides', 'up', and 'item'
    attr_accessor :sides, :up, :item, :colour, :num_randomizations
    COLOUR = {
        :red => "red",
        :green => "green",
        :blue => "blue",
        :yellow => "yellow",
        :black => "black",
    }

    def initialize(sides, colour)
        @sides = sides
        @colour = COLOUR.key?(colour) && colour || COLOUR.value?(colour) && COLOUR.key(colour)
        @up = nil
        @num_randomizations = 0
        @item = :die
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

    def description() # HELPER: get Die instance description
        description = super # get default description from parent class
        description[:colour] = @colour
        return description
    end
end
