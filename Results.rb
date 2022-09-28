class Results

    def initialize(cup)
        @description = nil
        @randomizer_descriptions = []
        cup.randomizers.each do |randomizer|
            @randomizer_descriptions << randomizer.description
        end
    end

    def description(description) # stores a description from which the Randomizer objects stored in self can be selected when computing the results, tally or sum 
        @description = description
    end

    def results() # returns array containing the “side-up” values of the randomizers recorded in self
        # only include the values from randomizers that match the description stored in the Results.
        # if description() has not yet been called, return the results from all randomizers
        sideup_values = []
        @randomizer_descriptions.each do |randomizer_description|
            if @description == nil || @description == randomizer_description
                sideup_values << randomizer_description[:up]
            end
        end
        return sideup_values
    end

    def tally() # returns the number of items in the Results that match the description 
        # if description() has not yet been called, count all randomizers
        num_matches = 0
        @randomizer_descriptions.each do |randomizer_description|
            if @description == nil || @description == randomizer_description
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
        @randomizer_descriptions.each do |randomizer_description|
            if @description == nil || @description == randomizer_description
                if randomizer_description.value?(:H) # no check for :T because it will not affect sideup_sum
                    sideup_sum += 1
                elsif randomizer_description.value?(:die)
                    sideup_sum += randomizer_description[:up]
                end
            end
        end
        return sideup_sum
    end

end
