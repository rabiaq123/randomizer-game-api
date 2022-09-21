class RandomizerContainer
    # you can have implementation in your abstract class; it's being used in assignment so you can hide some implementation details if needed
    # Bag, Hand, and Cup inherit from this abstract class
    # All RandomizerContainer objects are created empty. Therefore, they're just called with ‘new’ (e.g. Cup.new)
    # synonym: there's no technical meaning; the logic from one method will be similar to the logic in the other
    # abstract classes: you have no implementation in PURE abstract classes, but in abstract ones, you can
        # if the logic is the same, you can move it up to the abstract class
    
    # In the RandomizerContainer class, do all the classes that inherit from it have to implement each method, or can you just implement it in the Randomizer Class itself? Does this apply to all other abstract classes and classes that inherit from them (e.g., Die < Randomizer)?
        # A: you can just implement in this class, and this applies to all abstract classes for this assignment
    # empty() is an abstract method, how does that make it different from the rest of the methods in this class? 
        # A: dont have implementation in here, override it and implement in child class

    # since RandomizerContainer is an abstract class and doesnt have an initialize method, does that mean instance variables can't be created in it?
        # A: you won't have RandomizerContainer instances, but you will have instances of Bag, Hand, and Cup which are all RandomizerContainers. These containers have randomizers which could be Dice or Coins.
    # Do I need to create a randomizers array in my child classes and pass them into this class (e.g., Coin < Randomizer)
        # A: yes

    # What is a container? Is the container an array of randomizers? Like @randomizers?
        # A: a container can be an array; a Bag, Hand, or Cup object is a container which has an array of randomizers.
    # is rc in the method signature of move_all() an instance of this class?
        # A: rc can be a Bag, Cup, or Hand

    # move_all -> does "self" in that context refer to the keyword?
        # A: TA is not sure, ask professor
    # for Bag, when store() or move_all() invoked, assignment desc says Bag makes sure that all randomizers added to the bag are reset. Does this mean I need additional implementation within my Bag class for store()? 
        # A: yes, you need additional implementation for store() in Bag
        # What does "reset" mean in this context? 
            # A: he doesn't know, ask Professor


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

