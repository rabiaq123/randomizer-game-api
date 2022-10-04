require './RandomizerContainer'

class Cup < RandomizerContainer
  def initialize
    @randomizers = []
  end

  def throw # each randomizer in the cup is rolled or flipped, and a newly created Results object is returned
    @randomizers.each do |randomizer|
      randomizer.randomize
    end
    return Results.new(self)
  end

  def load(hand) # enters each randomizer from a Hand, is a synonym of move_all()
    move_all(hand)
  end

  def empty # returns a Hand object to be returned to the bag, and leaves the cup empty
    hand = Hand.new
    hand.move_all(self)
    return hand
  end
end
