require './RandomizerContainer.rb'

class Hand < RandomizerContainer
    attr_accessor :randomizers

    # Hand takes Coins and Dice from Bag instance and moves them to the Cup
    # Hand does no flipping

end
