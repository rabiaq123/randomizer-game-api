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
        assert({:sides=>2, :up=>nil, :item=>:coin, :denomination=>0.25} == coin1.description, "Coin 1's sideup value should not be set before being flipped, and should have a denomination of 0.25")
        assert({:sides=>2, :up=>nil, :item=>:coin, :denomination=>0.25} == coin2.description, "Coin 2's sideup value should not be set before being flipped, and should have a denomination of 0.25")
        assert({:sides=>2, :up=>nil, :item=>:coin, :denomination=>0.25} == coin3.description, "Coin 3's sideup value should not be set before being flipped, and should have a denomination of 0.25")

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
        assert(coin1.sideup == :H || coin1.sideup == :T, "Coin 1 should have a sideup value of :H or :T")
        assert(coin2.sideup == :H || coin2.sideup == :T, "Coin 2 should have a sideup value of :H or :T")
        assert(coin3.sideup == :H || coin3.sideup == :T, "Coin 3 should have a sideup value of :H or :T")
        
        # get results of all coin flips
        puts "\tGetting results of all coin flips"
        desc = {sides: 2, up: :H, item: :coin, denomination: 0.25}
        # .tally() returns the a tally hash of how many of each element are present 
        puts "\tPlayer 1 tally results: #{player1.tally(desc).tally()}"
        puts "\tPlayer 2 tally results: #{player2.tally(desc).tally()}"
        puts "\tPlayer 3 tally results: #{player3.tally(desc).tally()}"

        # clearing all tally results
        puts "\tClearing all tally results"
        player1.clear
        player2.clear
        player3.clear
        assert_equal(player1.tally(desc).tally(), {}, "Player 1's tally should be empty")
        assert_equal(player2.tally(desc).tally(), {}, "Player 2's tally should be empty")
        assert_equal(player3.tally(desc).tally(), {}, "Player 3's tally should be empty")
    end
    
    # Use Case 3: Advancing in Spots on a Game Board
    def test_uc_3 
        puts "\n\nTesting Use Case 3: Advancing in Spots on a Game Board\n"

        # create all players
        puts "\tCreating 'Player 1' and 'Player 2'"
        player1 = Player.new("Player 1")
        player2 = Player.new("Player 2")
        assert_equal(player1.name, "Player 1", "Player 1 should have name Player 1")
        assert_equal(player2.name, "Player 2", "Player 2 should have name Player 2")
        # create player coins
        puts "\tCreating two dice for each player"
        die1 = Die.new(6, :yellow) # player 1
        die2 = Die.new(6, :yellow)
        die3 = Die.new(6, :blue) # player 2
        die4 = Die.new(6, :blue)
        assert({:sides=>6, :up=>nil, :item=>:die, :colour=>:yellow} == die1.description, "Die is missing necessary attributes")
        assert_equal(die1.description, die2.description, "Die 1 and Die 2 should have the same description")
        assert({:sides=>6, :up=>nil, :item=>:die, :colour=>:blue} == die3.description, "Die is missing necessary attributes")
        assert_equal(die3.description, die4.description, "Die 3 and Die 4 should have the same description")

        # put players' dice in thier hands
        puts "\tPutting each player's dice in their hand"
        p1_hand = Hand.new
        p1_hand.store_all([die1, die2])
        p2_hand = Hand.new
        p2_hand.store_all([die3, die4])
        assert_not_nil(p1_hand.randomizers, "Player 1's hand should have 2 dice")
        assert_not_nil(p2_hand.randomizers, "Player 2's hand should have 2 dice")

        # put players' coins in thier bags
        puts "\tPutting each player's dice in their bag"
        player1.move_all(p1_hand)
        player2.move_all(p2_hand)
        # ensure randomizers are in bag
        assert_equal(player1.bag.randomizers.count, 2, "Player 1's bag should have 2 dice")
        assert_equal(player2.bag.randomizers.count, 2, "Player 2's bag should have 2 dice")
        assert(player1.bag.randomizers[0].sideup == nil && player1.bag.randomizers[1].sideup == nil, "Dice should not have a sideup value in bag")
        assert(player2.bag.randomizers[0].sideup == nil && player2.bag.randomizers[1].sideup == nil, "Dice should not have a sideup value in bag")
        # ensure randomizers are no longer in hand
        assert_equal(p1_hand.randomizers, [], "Player 1's hand should be empty")
        assert_equal(p2_hand.randomizers, [], "Player 2's hand should be empty")

        # transfer coins from players' bags to the cup
        puts "\tTransferring each player's dice from their bag to thier cup"
        player1.load
        assert_equal(player1.bag.randomizers, [], "Player 1's bag should be empty")
        assert_not_equal(player1.cup.randomizers, [], "Player 1's cup should not be empty")
        player2.load
        assert_equal(player2.bag.randomizers, [], "Player 2's bag should be empty")
        assert_not_equal(player2.cup.randomizers, [], "Player 2's cup should not be empty")

        # roll dice in cup
        puts "\tRolling dice"
        player1.throw
        player2.throw
        # expect dice to be rolled once
        assert_equal(die1.calls, 1, "Die 1 should have been rolled once")
        assert_equal(die2.calls, 1, "Die 2 should have been rolled once")
        assert_equal(die3.calls, 1, "Die 3 should have been rolled once")
        assert_equal(die4.calls, 1, "Die 4 should have been rolled once")
        assert(die1.sideup >= 1 && die1.sideup <= 6, "Die 1 should have a sideup value between 1 and 6")
        assert(die2.sideup >= 1 && die2.sideup <= 6, "Die 2 should have a sideup value between 1 and 6")
        assert(die3.sideup >= 1 && die3.sideup <= 6, "Die 3 should have a sideup value between 1 and 6")
        assert(die4.sideup >= 1 && die4.sideup <= 6, "Die 4 should have a sideup value between 1 and 6")
        
        # get results of all player rolls
        puts "\tGetting Player 1 and Player 2's dice results"
        puts "\tplayer1: #{die1.sideup} + #{die2.sideup} = #{die1.sideup + die2.sideup}"
        puts "\tplayer2: #{die3.sideup} + #{die4.sideup} = #{die3.sideup + die4.sideup}"

        # empty Player cups
        puts "\tEmptying Player 1 and Player 2's cups"
        player1.cup.empty
        player2.cup.empty
        assert_equal(player1.cup.randomizers, [], "Player 1's cup should be empty")
        assert_equal(player2.cup.randomizers, [], "Player 2's cup should be empty")
    end

    # Use Case 4: Getting two turns in a row
    def test_uc_4
        puts "\n\nTesting Use Case 4: Getting two turns in a row\n"

        # create all players
        puts "\tCreating 'Player 1' and 'Player 2'"
        player1 = Player.new("Player 1")
        player2 = Player.new("Player 2")
        assert_equal(player1.name, "Player 1", "Player 1 should have name Player 1")
        assert_equal(player2.name, "Player 2", "Player 2 should have name Player 2")
        # create die for players to share
        puts "\tCreating two dice for Player 1 to store in bag"
        die = Die.new(6, :yellow)
        assert({:sides=>6, :up=>nil, :item=>:die, :colour=>:yellow} == die.description, "Die is missing necessary attributes")

        # put players' dice in thier hands

        # put die in Player 1's hand
        puts "\tPutting die in Player 1's hand"
        p1_hand = Hand.new
        p1_hand.store(die)
        assert(p1_hand.randomizers.length == 1, "Player 1's hand should have 1 die")

        # put die in Player 1's coins in thier bags
        puts "\tPutting die in Player 1's bag"
        player1.move_all(p1_hand)
        # ensure randomizer is in bag and no longer in hand
        assert_equal(player1.bag.randomizers.count, 1, "Player 1's bag should have 1 die")
        assert_equal(p1_hand.randomizers, [], "Player 1's hand should be empty after moving die to bag")

        # transfer coins from players' bags to the cup
        puts "\tTransferring the die from Player 1's bag to thier cup"
        player1.load
        assert_equal(player1.bag.randomizers, [], "Player 1's bag should be empty")
        assert_not_equal(player1.cup.randomizers, [], "Player 1's cup should not be empty")

        # Player 1 rolls die in cup
        player1_turn = true
        num_calls = 0
        while player1_turn
            num_calls += 1
            puts "\tRolling die"
            player1.throw
            # expect die to be rolled once
            assert_equal(die.calls, num_calls, "Die should have been #{num_calls} time(s)")
            assert(die.sideup >= 1 && die.sideup <= 6, "Die should have a sideup value between 1 and 6")
            # get results of Player 1's roll
            puts "\tPlayer 1's roll result: #{die.sideup} out of #{die.sides}"

            if die.sideup == die.sides
                puts "\tPlayer 1 gets another turn"
            else
                puts "\tPlayer 1's turn is over"
                player1_turn = false
            end
        end

        # Player 2 picks die up
        puts "\tPutting die in Player 2's hand"
        p1_hand = player1.cup.empty
        p1_hand.empty
        p2_hand = Hand.new
        p2_hand.store(die)
        assert(player1.cup.randomizers == [] && p1_hand.randomizers == [], "Player 1's hand and cup should be empty")
        assert_equal(p2_hand.randomizers.count, 1, "Player 2's hand should have 1 die")
    end

    # Use Case 5: Breaking a tie
    def test_uc_5
        puts "\n\nTesting Use Case 5: Breaking a tie\n"

        # create all players
        puts "\tCreating 'Player 1' and 'Player 2'"
        player1 = Player.new("Player 1")
        player2 = Player.new("Player 2")
        assert_equal(player1.name, "Player 1", "Player 1 should have name Player 1")
        assert_equal(player2.name, "Player 2", "Player 2 should have name Player 2")
        # create dice for players to share
        puts "\tCreating two dice for Player 1 to store in bag"
        die1 = Die.new(5, :green)
        die2 = Die.new(5, :blue)
        die3 = Die.new(5, :red)
        die4 = Die.new(5, :yellow)
        assert({:sides=>5, :up=>nil, :item=>:die, :colour=>:green} == die1.description, "Die is missing necessary attributes")
        assert({:sides=>5, :up=>nil, :item=>:die, :colour=>:blue} == die2.description, "Die is missing necessary attributes")
        assert({:sides=>5, :up=>nil, :item=>:die, :colour=>:red} == die3.description, "Die is missing necessary attributes")
        assert({:sides=>5, :up=>nil, :item=>:die, :colour=>:yellow} == die4.description, "Die is missing necessary attributes")
        
        # put dice in Player 1's hand
        puts "\tPutting dice in Player 1's hand"
        p1_hand = Hand.new
        randomizers = [die4, die1, die2, die3]
        p1_hand.store_all(randomizers)
        assert(p1_hand.randomizers.length == 4, "Player 1's hand should have 4 dice")

        # put dice in Player 1's shared bag
        puts "\tPlacing dice in Player 1's bag"
        player1.move_all(p1_hand)
        # ensure randomizer is in bag and no longer in hand
        assert_equal(player1.bag.randomizers.count, 4, "Player 1's bag should have 4 dice")
        assert_equal(p1_hand.randomizers, [], "Player 1's hand should be empty after moving dice to bag")

        # put die in Player 1's cup
        puts "\tRandomly picking and placing one die in Player 1's cup"
        player1.load_some({}, 1)
        # ensure randomizer is in bag and no longer in hand
        assert_equal(player1.cup.randomizers.count, 1, "Player 1's cup should have 1 die")
        assert_equal(player1.bag.randomizers.count, 3, "Player 1's bag should have 3 dice")

        # setting desired die conditions
        die_criteria = {:up=>3, :colour=>:yellow}
        puts "\tDesired die is yellow and lands on 3"

        # Player 1 rolls die in cup
        tie_broken = false
        if player1.cup.randomizers[0].colour == die_criteria[:colour]
            puts "\tPlayer 1's die is desired colour"
            puts "\tRolling die"
            player1.throw
            # expect die to be rolled once
            assert(player1.cup.randomizers[0].sideup >= 1 && player1.cup.randomizers[0].sideup <= player1.cup.randomizers[0].sides, "Die should have a sideup value between 1 and #{player1.cup.randomizers[0].sides}")           

            # get results of Player 1's roll
            puts "\tPlayer 1's roll result: #{player1.cup.randomizers[0].sideup}"
            if player1.cup.randomizers[0].sideup == die_criteria[:up]
                puts "\tPlayer 1's die landed on desired value"
                puts "\tPlayer 1 broke the tie"
                tie_broken = true
            end
        end

        # Player 2's turn
        if tie_broken == false
            puts "\tPlayer 1's die did not match desired description"
            puts "\tPlayer 1's die: #{player1.cup.randomizers[0].description}"
            puts "\tPlayer 1's turn is over"   
            
            # Player 1 puts die back in bag and shares bag with Player 2
            puts "\tPlayer 1 places die back in shared bag for Player 2's turn"
            player1.replace
            player2.bag = player1.bag
            assert_equal(player1.bag.randomizers.count, 4, "Player 1's bag should have 4 dice")
            assert_equal(player2.bag.randomizers.count, 4, "Player 2's bag should have 4 dice")
        end

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

        puts "\tBefore flipping coin..."
        assert_equal(coin.sideup(), nil, "coin.sideup should return nil if the coin has not been flipped yet")
        puts "\t#{coin.description}"

        puts "\tFlipping coin..."
        coin.flip
        assert_not_nil(coin.sideup(), "coin.sideup should return :H or :T after coin is flipped")
        assert_equal(coin.calls(), 1, "coin.calls should return 1 since coin.flip was called once")
        puts "\t#{coin.description}"

        puts "\tResetting coin..."
        coin.reset
        assert_equal(coin.sideup(), nil, "coin.sideup should return nil after coin.reset")
        assert_equal(coin.calls(), 0, "coin.calls should return 0 after coin.reset")
        puts "\t#{coin.description}"
    end

end