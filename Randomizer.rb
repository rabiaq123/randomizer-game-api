class Randomizer
    ITEM = {
        :coin => 1,
        :die => 2,
    }
    SIDES = {
        :H => 1,
        :T => 0,
    }

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

    def description() # ADDED returns a string describing the object
        # :sides, :up, and :item all belong to Randomizer
        description = { sides: @sides, up: @up, item: @item } # default description
        if @item == :coin # if Coin, add :denomination
            description[:denomination] = @denomination
        elsif @item == :die # if Die, add :colour
            description[:colour] = @colour
        end
        return description
    end

end

