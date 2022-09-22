class Randomizer
    def randomize() # both randomizes as well as returns self (for method chaining)
        @num_randomizations += 1
        @up = rand(1..@sides)

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
end

