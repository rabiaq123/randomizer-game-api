require './RandomizerContainer.rb'

class Bag < RandomizerContainer
    attr_accessor :randomizers

    # Bag can contain Coins and Dice

    def initialize()
        @randomizers = []
    end

    def move_all(randomizer_container) # override parent class implementation
        super # call parent method and pass in the arg passed into this method
        @randomizers.each do |randomizer|
            randomizer.reset()
        end
        return self
    end

    def store_all(randomizers) # override parent class implementation
        super # call parent method and pass in the arg passed into this method
        @randomizers.each do |randomizer|
            randomizer.reset()
        end
        return self
    end

    def empty() # empties all items from the Bag into a Hand, which is returned
        hand = Hand.new()
        hand.move_all(self)
        return hand
    end

end
