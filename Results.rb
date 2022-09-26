require './Cup.rb'

class Results

    def initialize(cup)
        @cup = cup
        @description = nil
    end

    def description(description) # stores a description from which the Randomizer objects stored in self can be selected when computing the results, tally or sum 
        @description = description
    end

    def results() # returns array containing the “side-up” values of the randomizers recorded in self
        # only include the values from randomizers that match the description stored in the Results.
        # if description() has not yet been called, return the results from all randomizers
        sideup_values = []
        @cup.randomizers.each do |randomizer|
            if @description == nil || @description == randomizer.description
                sideup_values << randomizer.sideup()
            end
        end
        return sideup_values
    end

    def tally() # returns the number of items in the Results that match the description 
        # if description() has not yet been called, count all randomizers
        num_matches = 0
        @cup.randomizers.each do |randomizer|
            if @description == nil || @description == randomizer.description
                num_matches += 1
            end
        end
        return num_matches
    end

    def sum()
        # totals the sideup value of the Randomizer items in the Results that match the description, 
        # (for coins, :H = 1 and :T = 0), and returns the value
        # if description() has not yet been called, total the values across all randomizers
        sideup_sum = 0
        @cup.randomizers.each do |randomizer|
            if @description == nil || randomizer.description == @description
                if randomizer.sideup() == :H # no check for :T because it will not affect sideup_sum
                    sideup_sum += 1
                elsif randomizer.class.name == "Die"
                    sideup_sum += randomizer.sideup()
                end
            end
        end
        return sideup_sum
    end

end
