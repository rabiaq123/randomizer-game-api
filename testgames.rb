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

# # checking select method for multiple coins
puts "-------"
puts "Checking select method for multiple coins"
coin1 = Coin.new 0.25
coin2 = Coin.new 1
coin3 = Coin.new 0.25
coin4 = Coin.new 0.05
coin5 = Coin.new 0.10
coin6 = Coin.new 1
die = Die.new(6,"yellow")
coin1.flip # use .randomize for method chaining
coin2.flip # use .randomize for method chaining
coin3.flip # use .randomize for method chaining
coin4.flip # use .randomize for method chaining
coin5.flip # use .randomize for method chaining
coin6.flip # use .randomize for method chaining
die.roll # use .randomize for method chaining
puts "-- coins flipped!"
# puts "coin1.description: #{coin1.description}" # coin1 description
# puts "coin2.description: #{coin2.description}" # coin2 description
# puts "coin3.description: #{coin3.description}" # coin3 description
# puts "coin3.description: #{coin4.description}" # coin4 description
# puts "coin3.description: #{coin5.description}" # coin4 description
# puts "coin3.description: #{coin6.description}" # coin4 description
# puts "die.description: #{die.description}" # die description
# puts ""
puts "-- placing randomizers in bag"
bag = Bag.new
randomizers = [coin1, coin2, coin3, coin4, coin5, coin6, die]
# puts "randomizers: #{randomizers}"
# puts ""
bag.store_all(randomizers)
# puts "bag.randomizers: #{bag.randomizers}"
# puts ""
puts "-- selecting coins"
hand = bag.select({ item: :coin }, 1)
puts "items selected: #{hand.randomizers}"
puts ""
puts "items left: #{bag.randomizers}"
puts ""
puts "Done"
puts ""

# checking Die methods and attributes for one die
puts "-------"
puts "Die.rb"
die = Die.new(6,"yellow")
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
