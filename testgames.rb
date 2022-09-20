# test cases for testing class behaviour 
require './Coin.rb'
require './Die.rb'

puts "-------"
puts "Coin.rb"
coin = Coin.new 0.25 # Create class and save it in variable
puts coin.denomination
coin.flip # use .randomize for method chaining
puts coin.sideup # should be nil if flip() has not been called before
puts coin.calls # number of times randomize() has been called
puts "After reset"
coin.reset
puts coin.sideup # should be nil
puts "Done"
puts ""

puts "-------"
puts "Die.rb"
die = Die.new(6,"yellow") # Create class and save it in variable
puts die.colour
puts die.sides
die.roll # use .randomize for method chaining
puts die.sideup # should be nil if roll() has not been called before
puts die.calls # number of times randomize() has been called
puts "After reset"
die.reset
puts die.sideup # should be nil
puts "Done"
