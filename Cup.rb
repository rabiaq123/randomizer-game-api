require './RandomizerContainer.rb'
require './Results.rb'

class Cup < RandomizerContainer
    attr_accessor :randomizers

    def initialize()
        @randomizers = []
    end

    def throw() # each randomizer in the cup is rolled or flipped, and a newly created Results object is returned
        @randomizers.each do |randomizer|
            randomizer.class.name == "Coin" ? randomizer.flip() : randomizer.roll()
        end
        return Results.new(self)
    end

    def load(hand) # enters each randomizer from a Hand, is a synonym of move_all()
        move_all(hand)
    end

    def empty() # returns a Hand object to be returned to the bag, and leaves the cup empty
        hand = Hand.new()
        hand.randomizers = @randomizers
        @randomizers = []
        return hand
    end

end
