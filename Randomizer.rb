class Randomizer
    ITEM = {
        :coin => 1,
        :die => 2,
    }
    SIDES = {
        :H => 1,
        :T => 2,
    }

    def randomize() # both randomizes as well as returns self (for method chaining)
        @num_randomizations += 1
        @up = rand(1..@sides) # .. is inclusive, ... is exclusive

        if self.class.name == "Coin"
            @up = SIDES.key(@up)
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
        # puts "description: #{description}"
        return description
    end

end

