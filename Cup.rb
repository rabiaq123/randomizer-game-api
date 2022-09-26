require './RandomizerContainer.rb'

class Cup < RandomizerContainer
    attr_accessor :randomizers
    attr_reader :throw_descriptions

    def initialize()
        @randomizers = []
        @throw_descriptions = []
    end

    def throw() # each randomizer in the cup is rolled or flipped, and a newly created Results object is returned
        @randomizers.each do |randomizer|
            randomizer.randomize()
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
