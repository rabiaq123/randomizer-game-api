require_relative './A1_Classes.rb'
require "test/unit"

class TestUseCases < Test::Unit::TestCase

    # Use Case 2: Choosing Who Makes the First Move
    def test_uc_2
        puts "\n\nTesting Use Case 2: Choosing who makes the first move\n"

        # create all players
        puts "\tCreating 'Player 1', 'Player 2', and 'Player 3'"
        player1 = Player.new("Player 1")
        player2 = Player.new("Player 2")
        player3 = Player.new("Player 3")
        assert_equal(player1.name, "Player 1", "Player 1 should have name Player 1")
        assert_equal(player2.name, "Player 2", "Player 2 should have name Player 2")
        assert_equal(player3.name, "Player 3", "Player 3 should have name Player 3")

        # create player coins
        puts "\tCreating a quarter for each player"
        coin1 = Coin.new(0.25)
        coin2 = Coin.new(0.25)
        coin3 = Coin.new(0.25)
        assert(coin1.sideup == nil && coin1.denomination == 0.25, "Coin 1's sideup value should not be set before being flipped, and should have a denomination of 0.25")
        assert(coin2.sideup == nil && coin2.denomination == 0.25, "Coin 2's sideup value should not be set before being flipped, and should have a denomination of 0.25")
        assert(coin3.sideup == nil && coin3.denomination == 0.25, "Coin 3's sideup value should not be set before being flipped, and should have a denomination of 0.25")

        # put players' coins in thier bags
        puts "\tPutting each player's coin in their bag"
        player1.store(coin1)
        player2.store(coin2)
        player3.store(coin3)
        assert_not_nil(player1.bag.randomizers, "Player 1's bag should have a randomizer")
        assert_not_nil(player2.bag.randomizers, "Player 2's bag should have a randomizer")
        assert_not_nil(player3.bag.randomizers, "Player 3's bag should have a randomizer")

        # transfer coins from players' bags to the cup
        puts "\tTransferring each player's coin from their bag to thier cup"
        player1.load
        assert_equal(player1.bag.randomizers, [], "Player 1's bag should be empty")
        assert(player1.cup.randomizers.include?(coin1), "Player 1's cup should have coin 1")
        player2.load
        assert_equal(player2.bag.randomizers, [], "Player 2's bag should be empty")
        assert(player2.cup.randomizers.include?(coin2), "Player 2's cup should have coin 2")
        player3.load
        assert_equal(player3.bag.randomizers, [], "Player 3's bag should be empty")
        assert(player3.cup.randomizers.include?(coin3), "Player 3's cup should have coin 3")

        # flip all coins three times
        puts "\tFlipping all coins three times"
        3.times do
            player1.throw
            player2.throw
            player3.throw
        end

        # expect coin to be flipped three times at the end of the loop
        assert_equal(coin1.calls, 3, "Coin 1 should have been flipped three times")
        assert_equal(coin2.calls, 3, "Coin 2 should have been flipped three times")
        assert_equal(coin3.calls, 3, "Coin 3 should have been flipped three times")
        
        # get results of all coin flips
        puts "\tGetting results of all coin flips"
        desc = {sides: 2, up: :H, item: :coin, denomination: 0.25}
        # .tally() returns the a tally hash of how many of each element are present 
        puts "\tplayer1.tally: #{player1.tally(desc).tally()}"
        puts "\tplayer2.tally: #{player2.tally(desc).tally()}"
        puts "\tplayer3.tally: #{player3.tally(desc).tally()}"
    end

end

class TestOther < Test::Unit::TestCase

    # checking Coin methods and attributes for one coin
    def test_coin_flip
        puts "\nTesting Coin class methods and attributes\n"

        coin = Coin.new 0.25
        assert_equal(coin.item, :coin, "coin.item should return coin")
        assert_equal(coin.denomination, 0.25, "Denomination should be 0.25")
        assert_equal(coin.sides, 2, "Coin should have two sides by default")
        assert_equal(coin.num_randomizations, 0, "num_randomizations should be 0 on Coin instatntiation")

        puts "\tbefore flipping coin..."
        assert_equal(coin.sideup(), nil, "coin.sideup should return nil if the coin has not been flipped yet")
        puts "\t#{coin.description}"

        puts "\tflipping coin..."
        coin.flip
        assert_not_nil(coin.sideup(), "coin.sideup should return :H or :T after coin is flipped")
        assert_equal(coin.calls(), 1, "coin.calls should return 1 since coin.flip was called once")
        puts "\t#{coin.description}"

        puts "\tresetting coin..."
        coin.reset
        assert_equal(coin.sideup(), nil, "coin.sideup should return nil after coin.reset")
        assert_equal(coin.calls(), 0, "coin.calls should return 0 after coin.reset")
        puts "\t#{coin.description}"
    end

end