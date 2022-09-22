require './RandomizerContainer.rb'

class Hand < RandomizerContainer
    attr_accessor :randomizers

    # Hand takes Coins and Dice from Bag instance and moves them to the Cup
    # Hand does no flipping

    def initialize()
        @randomizers = []
    end

    def next() # removes and returns the last object added to the Hand, return nil if no objects are in the Hand
        if @randomizers.length == 0 
            return nil
        end
        return @randomizers.pop()
    end

    def empty() # removes the items from your hand (i.e., items are dropped on the ground)
        @randomizers = []
        return nil
    end

end
