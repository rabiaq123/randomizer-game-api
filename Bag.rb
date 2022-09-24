require './RandomizerContainer.rb'

class Bag < RandomizerContainer
    attr_accessor :randomizers

    # Bag instance can contain contains Coins and Dice

    def initialize()
        @randomizers = []
    end

    def empty() # empties all items from the Bag into a Hand, which is returned
        hand = Hand.new()
        hand.randomizers = @randomizers
        @randomizers = []
        return hand
    end

end
