# test cases for testing class behaviour
require './A1_Classes'
require 'test/unit'
extend Test::Unit::Assertions

# checking Coin methods and attributes for one coin
puts '-------'
puts 'Coin.rb'
coin = Coin.new 0.25
puts "coin.item: #{coin.item}" # should be coin
puts "coin.denomination: #{coin.denomination}"
puts "coin.sides: #{coin.sides}"
puts "coin.sideup: #{coin.sideup}" # should be nil
coin.flip # use .randomize for method chaining
puts '-- coin flipped!'
# puts coin.up # should give same result as coin.sideup
puts "coin.sideup: #{coin.sideup}" # should not be nil after flip()

test_result = assert_not_nil(coin.sideup, 'coin sideup value should not be nil after flipping')
puts "test_result: #{test_result}"

puts "coin.calls: #{coin.calls}" # number of times randomize() has been called
puts "coin.description: #{coin.description}" # coin description
coin.reset
puts '-- called reset!'
puts "coin.sideup: #{coin.sideup}" # should be nil
puts "coin.description: #{coin.description}" # get coin description
puts 'Done'
coin = nil
puts ''

# checking Die methods and attributes for one die
puts '-------'
puts 'Die.rb'
die = Die.new(6, :yellow)
puts "die.item: #{die.item}" # should be die
puts "die.colour: #{die.colour}"
puts "die.sides: #{die.sides}"
puts "die.sideup: #{die.sideup}" # should be nil
die.roll # use .randomize for method chaining
puts '-- die rolled!'
# puts die.up # should give same result as die.sideup
puts "die.sideup: #{die.sideup}" # should not be nil after roll()
puts "die.calls: #{die.calls}" # number of times randomize() has been called
puts "die.description: #{die.description}" # get die description
die.reset
puts '-- called reset!'
puts "die.sideup: #{die.sideup}" # should be nil
puts "die.description: #{die.description}" # get die description
puts 'Done'
die = nil
puts ''

# emptying cup
puts '-------'
puts 'Checking empty() method in Cup'
coin1 = Coin.new 0.25
die1 = Die.new(6, :green)
randomizers = [coin1, die1]
puts '-- putting randomizers in hand'
hand = Hand.new
cup = Cup.new
hand.store_all(randomizers)
hand.randomizers.each do |randomizer|
  randomizer.randomize
  puts randomizer.description
end
puts '-- moving randomizers to cup'
cup.move_all(hand)
puts 'cup'
cup.randomizers.each do |randomizer|
  puts randomizer.description
end
puts 'hand'
hand.randomizers.each do |randomizer|
  puts randomizer.description
end
puts '-- emptying cup into hand'
hand = cup.empty
puts 'cup'
cup.randomizers.each do |randomizer|
  puts randomizer.description
end
puts 'hand'
hand.randomizers.each do |randomizer|
  puts randomizer.description
end
puts ''
puts 'Done'
coin1, die1 = nil
puts ''

# emptying bag
puts '-------'
puts 'Checking empty() method in Bag'
coin1 = Coin.new 0.25
die1 = Die.new(6, :green)
randomizers = [coin1, die1]
puts '-- putting randomizers in hand'
hand = Hand.new
bag = Bag.new
hand.store_all(randomizers)
hand.randomizers.each do |randomizer|
  randomizer.randomize
  puts randomizer.description
end
puts '-- moving randomizers to bag'
bag.move_all(hand)
puts 'bag'
bag.randomizers.each do |randomizer|
  puts randomizer.description
end
puts 'hand'
hand.randomizers.each do |randomizer|
  puts randomizer.description
end
puts '-- emptying bag into hand'
hand = bag.empty
puts 'bag'
bag.randomizers.each do |randomizer|
  puts randomizer.description
end
puts 'hand'
hand.randomizers.each do |randomizer|
  puts randomizer.description
end
puts ''
puts 'Done'
coin1, die1 = nil
puts ''

# checking select method for multiple items
puts '-------'
puts 'Checking select method for multiple items in bag'
coin1 = Coin.new 0.25
coin2 = Coin.new 1
coin3 = Coin.new 1
die1 = Die.new(6, :green)
die2 = Die.new(3, :blue)
die3 = Die.new(5, :blue)
die4 = Die.new(4, :red)
randomizers = [coin1, coin2, coin3, die1, die2, die3, die4]
puts '-- putting randomizers in hand'
bag = Bag.new
hand = Hand.new
hand.store_all(randomizers)
hand.randomizers.each { |randomizer| randomizer.randomize }
hand.randomizers.each do |randomizer|
  puts randomizer.description
end
puts '-- moving randomizers to bag'
bag.move_all(hand)
puts '-- selecting all coins from bag'
hand = bag.select({ item: :coin }, :all)
puts 'items selected:'
hand.randomizers.each do |randomizer|
  puts randomizer.description
end
puts 'items left:'
bag.randomizers.each do |randomizer|
  puts randomizer.description
end
puts ''
puts 'Done'
coin1, coin2, coin3, die1, die2, die3, die4, randomizers, bag, hand = nil
puts ''

# checking select method for multiple items
puts '-------'
puts 'Checking select method for multiple items in cup'
coin1 = Coin.new 0.25
coin2 = Coin.new 1
coin3 = Coin.new 1
die1 = Die.new(6, :green)
die2 = Die.new(3, :blue)
die3 = Die.new(5, :blue)
die4 = Die.new(4, :red)
randomizers = [coin1, coin2, coin3, die1, die2, die3, die4]
puts '-- putting randomizers in hand'
hand = Hand.new
cup = Cup.new
hand.store_all(randomizers)
# hand.randomizers.each do |randomizer|
#     puts randomizer.description
# end
puts '-- moving randomizers to cup'
cup.move_all(hand)
cup.throw
puts '-- selecting all :H coins from cup'
hand = cup.select({ item: :coin, up: :H }, :all)
puts 'items selected:'
hand.randomizers.each do |randomizer|
  puts randomizer.description
end
puts 'items left:'
cup.randomizers.each do |randomizer|
  puts randomizer.description
end
puts ''
puts 'Done'
coin1, coin2, coin3, die1, die2, die3, die4, randomizers, hand, cup = nil
puts ''

# checking Results methods after cup is thrown
puts '-------'
puts 'Checking Results methods when cup is thrown'
coin1 = Coin.new 0.25
coin2 = Coin.new 1
die1 = Die.new(6, :green)
die2 = Die.new(3, :blue)
randomizers = [coin1, coin2, die1, die2]
puts '-- putting randomizers in hand'
hand = Hand.new
cup = Cup.new
hand.store_all(randomizers)
# hand.randomizers.each do |randomizer|
#     puts randomizer.description
# end
puts '-- moving randomizers to cup and getting Results values'
cup.move_all(hand)
results = cup.throw
cup.randomizers.each do |randomizer|
  puts randomizer.description
end
# results.description({sides: 2, up: :H, item: :coin, denomination: 0.25}) # if provided, must match randomizer.description exactly to affect results
puts '-- results:'
puts "resuts.sum: #{results.sum}" # sum of sideup values of all randomizers in the cup with a matching description
puts "resuts.tally: #{results.tally}" # number of randomizer descriptions after a throw that match the provided description
puts "resuts.results: #{results.results}" # sideup values of all randomizers in the cup with a matching description
puts ''
puts 'Done'
coin1, coin2, die1, die2, randomizers, hand, cup, results = nil
puts ''

# checking Player class implementation with Coins
puts '-------'
puts 'Player class implementation with Coins'
coin1 = Coin.new 0.25
coin2 = Coin.new 1
coin3 = Coin.new 1
coin4 = Coin.new 1
die1 = Die.new(6, :green)
die2 = Die.new(3, :blue)
randomizers = [coin1, coin2, coin3, coin4, die1, die2]
puts '-- putting randomizers in hand'
player = Player.new('Rabia')
hand = Hand.new
hand.store_all(randomizers)
# hand.randomizers.each do |randomizer|
#     puts randomizer.description
# end
puts '-- storing randomizers in bag'
player.move_all(hand)
# puts "player.bag.randomizers: #{player.bag.randomizers}"
# puts "hand.randomizers: #{hand.randomizers}"
puts '-- loading and throwing randomizers in cup'
player.load({ item: :coin })
desc = { sides: 2, up: :H, item: :coin, denomination: 1 }
puts "-- stats criteria: #{desc}"
player.throw
player.cup.randomizers.each do |randomizer|
  puts randomizer.description
end
puts "player.sum(): #{player.sum(desc)}" # sum of sideup values of all randomizers in the cup with a matching description
puts "player.tally(): #{player.tally(desc)}" # number of randomizer descriptions after a throw that match the provided description
puts "player.results(): #{player.results(desc, 0)}" # sideup values (from a given throw) of all randomizers in the cup matching the provided description
puts 'throw #2'
player.throw
player.cup.randomizers.each do |randomizer|
  puts randomizer.description
end
puts "player.sum(): #{player.sum(desc)}" # sum of sideup values of all randomizers in the cup with a matching description
puts "player.tally(): #{player.tally(desc)}" # number of randomizer descriptions after a throw that match the provided description
puts "player.results(): #{player.results(desc, 0)}" # sideup values (from a given throw) of all randomizers in the cup matching the provided description
puts 'throw #3'
player.throw
player.cup.randomizers.each do |randomizer|
  puts randomizer.description
end
puts "player.sum(): #{player.sum(desc)}" # sum of sideup values of all randomizers in the cup with a matching description
puts "player.tally(): #{player.tally(desc)}" # number of randomizer descriptions after a throw that match the provided description
puts "player.results(): #{player.results(desc, 0)}" # sideup values (from a given throw) of all randomizers in the cup matching the provided description
puts ''
puts 'Done'
coin1, coin2, coin3, coin4, die1, die2, randomizers, player, hand, desc = nil
puts ''

# checking Player class implementation with Dice
puts '-------'
puts 'Player class implementation with Dice'
die1 = Die.new(3, :blue)
die2 = Die.new(3, :green)
die3 = Die.new(3, :red)
die4 = Die.new(3, :yellow)
randomizers = [die1, die2, die3, die4]
puts '-- putting randomizers in hand'
player = Player.new('Rabia')
hand = Hand.new
hand.store_all(randomizers)
# hand.randomizers.each do |randomizer|
#     puts randomizer.description
# end
puts '-- storing randomizers in bag'
player.move_all(hand)
# puts "player.bag.randomizers: #{player.bag.randomizers}"
# puts "hand.randomizers: #{hand.randomizers}"
puts '-- loading and throwing randomizers in cup'
player.load({})
# desc = {sides: 3, up: 2, item: :die, colour: :blue}
desc = {}
puts "-- stats criteria: #{desc}"
player.throw
player.cup.randomizers.each do |randomizer|
  puts randomizer.description
end
puts "player.sum(): #{player.sum(desc)}" # sum of sideup values of all randomizers in the cup with a matching description
puts "player.tally(): #{player.tally(desc)}" # number of randomizer descriptions after a throw that match the provided description
puts "player.results(): #{player.results(desc, 0)}" # sideup values (from a given throw) of all randomizers in the cup matching the provided description
puts 'throw #2'
player.throw
player.cup.randomizers.each do |randomizer|
  puts randomizer.description
end
puts "player.sum(): #{player.sum(desc)}" # sum of sideup values of all randomizers in the cup with a matching description
puts "player.tally(): #{player.tally(desc)}" # number of randomizer descriptions after a throw that match the provided description
puts "player.results(): #{player.results(desc, 0)}" # sideup values (from a given throw) of all randomizers in the cup matching the provided description
puts 'throw #3'
player.throw
player.cup.randomizers.each do |randomizer|
  puts randomizer.description
end
puts "player.sum(): #{player.sum(desc)}" # sum of sideup values of all randomizers in the cup with a matching description
puts "player.tally(): #{player.tally(desc)}" # number of randomizer descriptions after a throw that match the provided description
puts "player.results(): #{player.results(desc, 0)}" # sideup values (from a given throw) of all randomizers in the cup matching the provided description
puts ''
puts 'Done'
coin1, coin2, coin3, coin4, die1, die2, randomizers, player, hand, desc = nil
puts ''
