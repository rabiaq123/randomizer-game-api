class Player
    attr_accessor :bag, :cup
    
    # every Player has a Bag and a Cup

    def initialize(name)
        @name = name
        @bag = Bag.new
        @cup = Cup.new
        @throw_results = []
    end

    def name() # returns the name of the player (does not set it)
        return @name
    end

    def store(item) # stores the item in the player's bag; returns self (for method chaining)
        @bag.store(item)
        return self
    end

    def move_all(randomizer_container) # gets each item in rc and stores it in the player’s bag; returns self (for method chaining)
        @bag.move_all(randomizer_container)
        return self
    end

    def load(description = {}) # loads items from the player’s bag to the player’s cup based on the description; returns self (for method chaining)
        @cup.load(@bag.select(description, :all))
        return self
    end

    def throw() # throws the loaded cup
        # store and return the Results of the "thrown items" (which are still stored in the cup)
        @throw_results << @cup.throw()
        return @throw_results.last
    end

    def replace(description = {}) # replaces the items selected by the description from the cup into the bag; returns self (for method chaining)
        @bag.move_all(@cup.select(description, :all))
        return self
    end

    def clear() # clears all stored results; returns self (for method chaining)
        @throw_results = []
        return self
    end

    def tally(description = {}) # sets the description, and calls tally() on each of the stored results, and returns each of the values within a single array
        tally_results = []
        
        @throw_results.each do |result|
            result.description(description) # set the description
            tally_results << result.tally() # store the tallied results
        end

        return tally_results
    end

    def sum(description = {}) # sets the description, and calls sum() on each of the stored results and returns the combined values as an array
        sum_arr = []
        
        @throw_results.each do |result|
            result.description(description) # set the description
            sum_arr << result.sum() # store the summed results
        end
        
        return sum_arr
    end

    def results(description = {}, throw = 0) # sets the description and returns the Result values as an array, where the last Results is “throw=0”, the throw before is “throw=1”, etc
        # a “throw” is short for “the result of a given throw”
        idx = -(throw + 1) # negative index values can be used to access elements from the end of the array

        # if a throw is requested that doesn’t exist (too far back in time and never occurred), return nil
        if @throw_results[idx] == nil
            return nil
        end

        @throw_results[idx].description(description) 
        return @throw_results[idx].results()
    end

    def load_some(description = {}, amt) # HELPER: loads 'amt' items from the player’s bag to the player’s cup based on the description; returns self (for method chaining)
        @cup.load(@bag.select(description, amt))
        return self
    end

end