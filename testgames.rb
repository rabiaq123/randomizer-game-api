# test cases for testing class behaviour 
require './Coin.rb'
require './Die.rb'

puts "-------"
puts "Coin.rb"
coin = Coin.new 0.25 # Create class and save it in variable
puts "coin.item: #{coin.item}" # should be coin
puts "coin.denomination: #{coin.denomination}"
puts "coin.sides: #{coin.sides}"
puts "coin.sideup: #{coin.sideup}" # should be nil
coin.flip # use .randomize for method chaining
puts "-- coin flipped!"
# puts coin.up # should give same result as coin.sideup
puts "coin.sideup: #{coin.sideup}" # should not be nil after flip()
puts "coin.calls: #{coin.calls}" # number of times randomize() has been called
coin.reset
puts "-- called reset!"
puts "coin.sideup: #{coin.sideup}" # should be nil
puts "Done"
puts ""

puts "-------"
puts "Die.rb"
die = Die.new(6,"yellow") # Create class and save it in variable
puts "die.item: #{die.item}" # should be die
puts "die.colour: #{die.colour}"
puts "die.sides: #{die.sides}"
puts "die.sideup: #{die.sideup}" # should be nil
die.roll # use .randomize for method chaining
puts "-- die rolled!"
# puts die.up # should give same result as die.sideup
puts "die.sideup: #{die.sideup}" # should not be nil after roll()
puts "die.calls: #{die.calls}" # number of times randomize() has been called
die.reset
puts "-- called reset!"
puts "die.sideup: #{die.sideup}" # should be nil
puts "Done"
