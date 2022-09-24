require './Cup.rb'

class Results

    def initialize(cup)
        @cup = cup
        @description = nil
    end

    def description(description) # Stores a description from which the Randomizer objects stored in self can be selected when computing the results, tally or sum 
        @description = description
        return nil
    end

    def results() # returns array containing the “side-up” values of the randomizers recorded in self
        # Only include the values from randomizers that match the description stored in the Results.
        # If description() has not yet been called, return the results from all randomizers
        results = []
        @cup.randomizers.each do |randomizer|
            if @description == nil || randomizer.description == @description
                results << randomizer.sideup()
            end
        end
        return results
    end

    def tally() # returns the number of items in the Results that match the description 
        # if description() has not yet been called, count all randomizers
        tally = 0
        @cup.randomizers.each do |randomizer|
            if @description == nil || randomizer.description == @description
                tally += 1
            end
        end
        return tally
    end

    def sum()
        # totals the value of the randomizer items in the Results that match the description, where the value equals the number that is “up” (for coins, :H = 1 and :T = 0), and returns the value
        # if description() has not yet been called, total the values across all randomizers
        sum = 0
        @cup.randomizers.each do |randomizer|
            if @description == nil || randomizer.description == @description
                if randomizer.sideup() == :H
                    sum += 1
                elsif randomizer.sideup() == :T
                    sum += 2
                elsif randomizer.sideup().is_a? Integer # for dice
                    sum += randomizer.sideup()
                end
            end
        end
        return sum
    end

end
