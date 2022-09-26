# test cases for testing class behaviour 
require './A1_Classes.rb'

# checking Coin methods and attributes for one coin
puts "-------"
puts "Coin.rb"
coin = Coin.new 0.25
puts "coin.item: #{coin.item}" # should be coin
puts "coin.denomination: #{coin.denomination}"
puts "coin.sides: #{coin.sides}"
puts "coin.sideup: #{coin.sideup}" # should be nil
coin.flip # use .randomize for method chaining
puts "-- coin flipped!"
# puts coin.up # should give same result as coin.sideup
puts "coin.sideup: #{coin.sideup}" # should not be nil after flip()
puts "coin.calls: #{coin.calls}" # number of times randomize() has been called
puts "coin.description: #{coin.description}" # coin description
coin.reset
puts "-- called reset!"
puts "coin.sideup: #{coin.sideup}" # should be nil
puts "coin.description: #{coin.description}" # get coin description
puts "Done"
puts ""


# checking select method for multiple items
puts "-------"
puts "Checking select method for multiple items in bag"
coin1 = Coin.new 0.25
coin2 = Coin.new 1
coin3 = Coin.new 1
die1 = Die.new(6, :green)
die2 = Die.new(3, :blue)
die3 = Die.new(5, :blue)
die4 = Die.new(4, :red)
randomizers = [coin1, coin2, coin3, die1, die2, die3, die4]
puts "-- putting randomizers in hand"
bag = Bag.new
hand = Hand.new
hand.store_all(randomizers)
hand.randomizers.each { |randomizer| randomizer.randomize }
# hand.randomizers.each do |randomizer|
#   puts randomizer.description
# end
puts "-- moving randomizers to bag"
bag.move_all(hand)
puts "-- selecting from bag"
hand = bag.select({}, :all) 
puts "items selected:"
hand.randomizers.each do |randomizer|
  puts randomizer.description
end
puts "items left:"
bag.randomizers.each do |randomizer|
  puts randomizer.description
end
puts ""
puts "Done"
puts ""


# checking select method for multiple items
puts "-------"
puts "Checking select method for multiple items in cup"
coin1 = Coin.new 0.25
coin2 = Coin.new 1
coin3 = Coin.new 1
die1 = Die.new(6, :green)
die2 = Die.new(3, :blue)
die3 = Die.new(5, :blue)
die4 = Die.new(4, :red)
randomizers = [coin1, coin2, coin3, die1, die2, die3, die4]
puts "-- putting randomizers in hand"
hand = Hand.new
cup = Cup.new
hand.store_all(randomizers)
# hand.randomizers.each do |randomizer|
#     puts randomizer.description
# end
puts "-- moving randomizers to cup"
cup.move_all(hand)
cup.throw
puts "-- selecting"
hand = cup.select({item: :coin, up: :H}, :all) 
puts "items selected:"
hand.randomizers.each do |randomizer|
  puts randomizer.description
end
puts "items left:"
cup.randomizers.each do |randomizer|
  puts randomizer.description
end
puts ""
puts "Done"
puts ""


# checking Die methods and attributes for one die
puts "-------"
puts "Die.rb"
die = Die.new(6, :yellow)
puts "die.item: #{die.item}" # should be die
puts "die.colour: #{die.colour}"
puts "die.sides: #{die.sides}"
puts "die.sideup: #{die.sideup}" # should be nil
die.roll # use .randomize for method chaining
puts "-- die rolled!"
# puts die.up # should give same result as die.sideup
puts "die.sideup: #{die.sideup}" # should not be nil after roll()
puts "die.calls: #{die.calls}" # number of times randomize() has been called
puts "die.description: #{die.description}" # get die description
die.reset
puts "-- called reset!"
puts "die.sideup: #{die.sideup}" # should be nil
puts "die.description: #{die.description}" # get die description
puts "Done"
