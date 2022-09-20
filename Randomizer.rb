class Randomizer
    @@num_randomizations = 0

    module CoinSide
        H = 1
        T = 2
    end

    def randomize() # both randomizes as well as returns self (for method chaining)
        @@num_randomizations += 1

        if self.class.name == Coin
            side = rand(CoinSide::H..CoinSide::T)
            if side == CoinSide::H
                @up = :H
            else
                @up = :T
            end
        # elsif self.class.name == Die
        #     @up = rand(1..6)
        end

        return self
    end

    def result() # returns the result of the randomization, or nil if never randomized
        return @up
    end

    def calls() # returns the number of randomizations performed
        return @@num_randomizations
    end

    def reset() # sets the result to nil and number of randomizations performed to 0, returns self (for method chaining)
        return self
    end
end

