class Randomizer
    SIDES = {
        :H => 1,
        :T => 0,
    }

    attr_accessor :description

    def randomize() # both randomizes as well as returns self (for method chaining)
        @num_randomizations += 1

        if self.class.name == "Coin"
            @up = SIDES.key(rand(2)) # between 0 and 1; 0 is :T, 1 is :H
        elsif self.class.name == "Die"
            @up = rand(1..@sides) # .. is inclusive, ... is exclusive
        end

        return self
    end

    def result() # returns the result of the randomization, or nil if never randomized
        return @up
    end

    def calls() # returns the number of randomizations performed
        return @num_randomizations
    end

    def reset() # sets the result to nil and number of randomizations performed to 0, returns self (for method chaining)
        @num_randomizations = 0
        @up = nil

        return self
    end

    def description() # HELPER: returns a string describing the object
        description = { sides: @sides, up: @up, item: @item } # default description
        return description
    end

end

