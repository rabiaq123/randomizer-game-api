class RandomizerContainer
    def store() # stores a randomizer in the container, returns self (for method chaining)
        @randomizers << self
        return self
    end

    def store_all(randomizers) # stores all randomizers in the container, returns self (for method chaining)
        @randomizers << randomizers
        return self
    end

    def count() # returns the number of all randomizers stored in itself
        return @randomizers.length
    end

    def move_all(randomizer_container) # remove each randomizer in container and store in self, returns self (for method chaining)
        @randomizers << randomizer_container
        randomizer_container = nil
        return self
    end

    def empty() # abstract method to remove all members from the container
        @randomizers = [] # resetting randomizers container
        return self
    end

    def select(description, amt)
        # selects items based on the description provided
        # remove the selected items from self;
        # returns a Hand object that holds the selected items up to the number entered into amount
        # (if you want all items, supply the symbol :all instead of a number)
    end

end

