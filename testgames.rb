require_relative './A1_Classes.rb'
require "test/unit"

class TestUseCases < Test::Unit::TestCase
    # set text colour when appended with '.blue' to show in terminal
    module Colours
        def blue
            "\e[#{36}m#{self}\e[0m"
        end
    end
    String.include(Colours)

    # Use Case 2: Choosing Who Makes the First Move
    def test_uc_2
        puts "\n\nTesting Use Case 2: Choosing who makes the first move\n"

        # create all players
        puts "\tCreating 'Player 1', 'Player 2', and 'Player 3'"
        player1 = Player.new("Player 1")
        player2 = Player.new("Player 2")
        player3 = Player.new("Player 3")
        puts "\t\tPlayer names" + " EXPECTED: ".blue + "Player 1, Player 2, Player 3;" + " RECEIVED: ".blue + "#{player1.name}, #{player2.name}, #{player3.name}"
        assert_equal(player1.name, "Player 1", "Player 1 should have name Player 1")
        assert_equal(player2.name, "Player 2", "Player 2 should have name Player 2")
        assert_equal(player3.name, "Player 3", "Player 3 should have name Player 3")

        # create player coins
        puts "\tCreating a quarter for each player"
        coin1 = Coin.new(0.25)
        coin2 = Coin.new(0.25)
        coin3 = Coin.new(0.25)
        puts "\t\tCoin 1 description" + " EXPECTED: ".blue + "{:sides=>2, :up=>nil, :item=>:coin, :denomination=>0.25}" + " RECEIVED: ".blue + "#{coin1.description}"
        puts "\t\tCoin 2 description" + " EXPECTED: ".blue + "{:sides=>2, :up=>nil, :item=>:coin, :denomination=>0.25}" + " RECEIVED: ".blue + "#{coin2.description}"
        puts "\t\tCoin 3 description" + " EXPECTED: ".blue + "{:sides=>2, :up=>nil, :item=>:coin, :denomination=>0.25}" + " RECEIVED: ".blue + "#{coin3.description}"
        assert({:sides=>2, :up=>nil, :item=>:coin, :denomination=>0.25} == coin1.description, "Coin 1's sideup value should not be set before being flipped, and should have a denomination of 0.25")
        assert({:sides=>2, :up=>nil, :item=>:coin, :denomination=>0.25} == coin2.description, "Coin 2's sideup value should not be set before being flipped, and should have a denomination of 0.25")
        assert({:sides=>2, :up=>nil, :item=>:coin, :denomination=>0.25} == coin3.description, "Coin 3's sideup value should not be set before being flipped, and should have a denomination of 0.25")

        # put players' coins in their bags
        puts "\tPutting each player's coin in their bag"
        player1.store(coin1)
        player2.store(coin2)
        player3.store(coin3)
        puts "\t\tNum randomizers in Player 1's bag" + " EXPECTED ".blue + "1" + " RECEIVED: ".blue + "#{player1.bag.randomizers.length}"
        puts "\t\tNum randomizers in Player 2's bag" + " EXPECTED ".blue + "1" + " RECEIVED: ".blue + "#{player2.bag.randomizers.length}"
        puts "\t\tNum randomizers in Player 3's bag" + " EXPECTED ".blue + "1" + " RECEIVED: ".blue + "#{player3.bag.randomizers.length}"
        assert_not_nil(player1.bag.randomizers, "Player 1's bag should have a randomizer")
        assert_not_nil(player2.bag.randomizers, "Player 2's bag should have a randomizer")
        assert_not_nil(player3.bag.randomizers, "Player 3's bag should have a randomizer")

        # transfer coins from players' bags to the cup
        puts "\tTransferring each player's coin from their bag to their cup"
        player1.load
        puts "\t\tContents in Player 1's bag" + " EXPECTED ".blue + "[]" + " RECEIVED: ".blue + "#{player1.bag.randomizers}"
        puts "\t\tNum randomizers in Player 1's cup" + " EXPECTED ".blue + "1" + " RECEIVED: ".blue + "#{player1.cup.randomizers.length}"
        assert_equal(player1.bag.randomizers, [], "Player 1's bag should be empty")
        assert(player1.cup.randomizers.include?(coin1), "Player 1's cup should have coin 1")
        player2.load
        puts "\t\tContents in Player 2's bag" + " EXPECTED ".blue + "[]" + " RECEIVED: ".blue + "#{player2.bag.randomizers}"
        puts "\t\tNum randomizers in Player 2's cup" + " EXPECTED ".blue + "1" + " RECEIVED: ".blue + "#{player2.cup.randomizers.length}"
        assert_equal(player2.bag.randomizers, [], "Player 2's bag should be empty")
        assert(player2.cup.randomizers.include?(coin2), "Player 2's cup should have coin 2")
        player3.load
        puts "\t\tContents in Player 3's bag" + " EXPECTED ".blue + "[]" + " RECEIVED: ".blue + "#{player3.bag.randomizers}"
        puts "\t\tNum randomizers in Player 3's cup" + " EXPECTED ".blue + "1" + " RECEIVED: ".blue + "#{player3.cup.randomizers.length}"
        assert_equal(player3.bag.randomizers, [], "Player 3's bag should be empty")
        assert(player3.cup.randomizers.include?(coin3), "Player 3's cup should have coin 3")

        # flip all coins three times
        puts "\tFlipping each coin three times"
        3.times do
            player1.throw
            player2.throw
            player3.throw
        end

        # expect coin to be flipped three times at the end of the loop
        puts "\t\tNum flips for coin 1" + " EXPECTED ".blue + "3" + " RECEIVED: ".blue + "#{coin1.calls}"
        puts "\t\tNum flips for coin 2" + " EXPECTED ".blue + "3" + " RECEIVED: ".blue + "#{coin2.calls}"
        puts "\t\tNum flips for coin 3" + " EXPECTED ".blue + "3" + " RECEIVED: ".blue + "#{coin3.calls}"
        assert_equal(coin1.calls, 3, "Coin 1 should have been flipped three times")
        assert_equal(coin2.calls, 3, "Coin 2 should have been flipped three times")
        assert_equal(coin3.calls, 3, "Coin 3 should have been flipped three times")
        puts "\t\tCoin 1 sideup" + " EXPECTED ".blue + "H or T" + " RECEIVED: ".blue + "#{coin1.sideup}"
        puts "\t\tCoin 2 sideup" + " EXPECTED ".blue + "H or T" + " RECEIVED: ".blue + "#{coin2.sideup}"
        puts "\t\tCoin 3 sideup" + " EXPECTED ".blue + "H or T" + " RECEIVED: ".blue + "#{coin3.sideup}"
        assert(coin1.sideup == :H || coin1.sideup == :T, "Coin 1 should have a sideup value of :H or :T")
        assert(coin2.sideup == :H || coin2.sideup == :T, "Coin 2 should have a sideup value of :H or :T")
        assert(coin3.sideup == :H || coin3.sideup == :T, "Coin 3 should have a sideup value of :H or :T")

        # get results of all coin flips
        puts "\tGetting results of all coin flips"
        desc = {sides: 2, up: :H, item: :coin, denomination: 0.25}
        puts "\t\tPlayer 1 tally results: #{player1.tally(desc)}"
        puts "\t\tPlayer 2 tally results: #{player2.tally(desc)}"
        puts "\t\tPlayer 3 tally results: #{player3.tally(desc)}"

        # clearing all tally results
        puts "\tClearing all tally results"
        player1.clear
        player2.clear
        player3.clear
        puts "\t\tPlayer 1's tally" + " EXPECTED ".blue + "[]" + " RECEIVED: ".blue + "#{player1.tally(desc)}"
        puts "\t\tPlayer 2's tally" + " EXPECTED ".blue + "[]" + " RECEIVED: ".blue + "#{player2.tally(desc)}"
        puts "\t\tPlayer 3's tally" + " EXPECTED ".blue + "[]" + " RECEIVED: ".blue + "#{player3.tally(desc)}"
        assert_equal(player1.tally(desc), [], "Player 1's tally should be empty")
        assert_equal(player2.tally(desc), [], "Player 2's tally should be empty")
        assert_equal(player3.tally(desc), [], "Player 3's tally should be empty")
    end

    # Use Case 3: Advancing in Spots on a Game Board
    def test_uc_3
        puts "\n\nTesting Use Case 3: Advancing in Spots on a Game Board\n"

        # create all players
        puts "\tCreating 'Player 1' and 'Player 2'"
        player1 = Player.new("Player 1")
        player2 = Player.new("Player 2")
        puts "\t\tPlayer names" + " EXPECTED: ".blue + "Player 1, Player 2;" + " RECEIVED: ".blue + "#{player1.name}, #{player2.name}"
        assert_equal(player1.name, "Player 1", "Player 1 should have name Player 1")
        assert_equal(player2.name, "Player 2", "Player 2 should have name Player 2")
        # create player dice
        puts "\tCreating two dice for each player"
        die1 = Die.new(6, :yellow) # player 1
        die2 = Die.new(6, :yellow)
        die3 = Die.new(6, :blue) # player 2
        die4 = Die.new(6, :blue)
        puts "\t\tPlayer 1's dice attributes" + " EXPECTED: ".blue + "{:sides=>6, :up=>nil, :item=>:die, :colour=>:yellow};" + " RECEIVED: ".blue + "#{die1.description}"
        assert({:sides=>6, :up=>nil, :item=>:die, :colour=>:yellow} == die1.description, "Die is missing necessary attributes")
        assert_equal(die1.description, die2.description, "Die 1 and Die 2 should have the same description")
        puts "\t\tPlayer 2's dice attributes" + " EXPECTED: ".blue + "{:sides=>6, :up=>nil, :item=>:die, :colour=>:blue};" + " RECEIVED: ".blue + "#{die3.description}"
        assert({:sides=>6, :up=>nil, :item=>:die, :colour=>:blue} == die3.description, "Die is missing necessary attributes")
        assert_equal(die3.description, die4.description, "Die 3 and Die 4 should have the same description")

        # put players' dice in their hands
        puts "\tPutting each player's dice in their hand"
        p1_hand = Hand.new
        p1_hand.store_all([die1, die2])
        p2_hand = Hand.new
        p2_hand.store_all([die3, die4])
        puts "\t\tNum randomizers in Player 1's hand" + " EXPECTED: ".blue + "2;" + " RECEIVED: ".blue + "#{p1_hand.randomizers.length}"
        puts "\t\tNum randomizers in Player 2's hand" + " EXPECTED: ".blue + "2;" + " RECEIVED: ".blue + "#{p2_hand.randomizers.length}"
        assert_not_nil(p1_hand.randomizers, "Player 1's hand should have 2 dice")
        assert_not_nil(p2_hand.randomizers, "Player 2's hand should have 2 dice")

        # put players' coins in their bags
        puts "\tPutting each player's dice in their bag"
        player1.move_all(p1_hand)
        player2.move_all(p2_hand)
        # ensure randomizers are no longer in hand
        puts "\t\tNum randomizers in Player 1's hand" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{p1_hand.randomizers.length}"
        puts "\t\tNum randomizers in Player 2's hand" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{p2_hand.randomizers.length}"
        assert_equal(p1_hand.randomizers, [], "Player 1's hand should be empty")
        assert_equal(p2_hand.randomizers, [], "Player 2's hand should be empty")
        # ensure randomizers are in bag
        puts "\t\tNum randomizers in Player 1's bag" + " EXPECTED: ".blue + "2;" + " RECEIVED: ".blue + "#{player1.bag.randomizers.length}"
        puts "\t\tNum randomizers in Player 2's bag" + " EXPECTED: ".blue + "2;" + " RECEIVED: ".blue + "#{player2.bag.randomizers.length}"
        assert_equal(player1.bag.randomizers.count, 2, "Player 1's bag should have 2 dice")
        assert_equal(player2.bag.randomizers.count, 2, "Player 2's bag should have 2 dice")
        puts "\t\tSideup values of dice in Player 1's bag are nil" + " EXPECTED: ".blue + "true;" + " RECEIVED: ".blue + "#{player1.bag.randomizers[0].sideup == nil && player1.bag.randomizers[1].sideup == nil}"
        puts "\t\tSideup values of dice in Player 2's bag are nil" + " EXPECTED: ".blue + "true;" + " RECEIVED: ".blue + "#{player2.bag.randomizers[0].sideup == nil && player2.bag.randomizers[1].sideup == nil}"
        assert(player1.bag.randomizers[0].sideup == nil && player1.bag.randomizers[1].sideup == nil, "Dice should not have a sideup value in bag")
        assert(player2.bag.randomizers[0].sideup == nil && player2.bag.randomizers[1].sideup == nil, "Dice should not have a sideup value in bag")

        # transfer coins from players' bags to the cup
        puts "\tTransferring each player's dice from their bag to their cup"
        player1.load
        puts "\t\tNum randomizers in Player 1's bag" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{player1.bag.randomizers.length}"
        puts "\t\tNum randomizers in Player 1's cup" + " EXPECTED: ".blue + "2;" + " RECEIVED: ".blue + "#{player1.cup.randomizers.length}"
        assert_equal(player1.bag.randomizers, [], "Player 1's bag should be empty")
        assert_not_equal(player1.cup.randomizers, [], "Player 1's cup should not be empty")
        player2.load
        puts "\t\tNum randomizers in Player 2's bag" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{player2.bag.randomizers.length}"
        puts "\t\tNum randomizers in Player 2's cup" + " EXPECTED: ".blue + "2;" + " RECEIVED: ".blue + "#{player2.cup.randomizers.length}"
        assert_equal(player2.bag.randomizers, [], "Player 2's bag should be empty")
        assert_not_equal(player2.cup.randomizers, [], "Player 2's cup should not be empty")

        # roll dice in cup
        puts "\tRolling dice"
        player1.throw
        player2.throw
        # expect dice to be rolled once
        puts "\t\tNum randomizations performed on each die is 1" + " EXPECTED: ".blue + "true;" + " RECEIVED: ".blue + "#{die1.calls == 1 && die2.calls == 1 && die3.calls == 1 && die4.calls == 1}"
        assert_equal(die1.calls, 1, "Die 1 should have been rolled once")
        assert_equal(die2.calls, 1, "Die 2 should have been rolled once")
        assert_equal(die3.calls, 1, "Die 3 should have been rolled once")
        assert_equal(die4.calls, 1, "Die 4 should have been rolled once")
        puts "\t\tSideup values of Player 1's dice are not out of range" + " EXPECTED: ".blue + "true;" + " RECEIVED: ".blue + "#{die1.sideup >= 1 && die1.sideup <= 6 && die2.sideup >= 1 && die2.sideup <= 6}"
        puts "\t\tSideup values of Player 2's dice are not out of range" + " EXPECTED: ".blue + "true;" + " RECEIVED: ".blue + "#{die3.sideup >= 1 && die3.sideup <= 6 && die4.sideup >= 1 && die4.sideup <= 6}"
        assert(die1.sideup >= 1 && die1.sideup <= 6, "Die 1 should have a sideup value between 1 and 6")
        assert(die2.sideup >= 1 && die2.sideup <= 6, "Die 2 should have a sideup value between 1 and 6")
        assert(die3.sideup >= 1 && die3.sideup <= 6, "Die 3 should have a sideup value between 1 and 6")
        assert(die4.sideup >= 1 && die4.sideup <= 6, "Die 4 should have a sideup value between 1 and 6")

        # get results of all player rolls
        puts "\tGetting Player 1 and Player 2's dice results"
        puts "\t\tplayer1: #{die1.sideup} + #{die2.sideup} = #{die1.sideup + die2.sideup}"
        puts "\t\tplayer2: #{die3.sideup} + #{die4.sideup} = #{die3.sideup + die4.sideup}"

        # empty Player cups
        puts "\tEmptying Player 1 and Player 2's cups"
        player1.cup.empty
        player2.cup.empty
        puts "\t\tNum randomizers in Player 1's cup" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{player1.cup.randomizers.length}"
        puts "\t\tNum randomizers in Player 2's cup" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{player2.cup.randomizers.length}"
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
        puts "\t\tPlayer names" + " EXPECTED: ".blue + "Player 1, Player 2;" + " RECEIVED: ".blue + "#{player1.name}, #{player2.name}"
        assert_equal(player1.name, "Player 1", "Player 1 should have name Player 1")
        assert_equal(player2.name, "Player 2", "Player 2 should have name Player 2")
        # create die for players to share
        puts "\tCreating two dice for Player 1 to store in bag"
        die = Die.new(6, :yellow)
        puts "\t\tDie description" + " EXPECTED: ".blue + "{:sides=>6, :up=>nil, :item=>:die, :colour=>:yellow}" + " RECEIVED: ".blue + "#{die.description}"
        assert({:sides=>6, :up=>nil, :item=>:die, :colour=>:yellow} == die.description, "Die is missing necessary attributes")

        # put die in Player 1's hand
        puts "\tPutting die in Player 1's hand"
        p1_hand = Hand.new
        p1_hand.store(die)
        puts "\t\tNum randomizers in Player 1's hand" + " EXPECTED: ".blue + "1;" + " RECEIVED: ".blue + "#{p1_hand.randomizers.length}"
        assert(p1_hand.randomizers.length == 1, "Player 1's hand should have 1 die")

        # put die in Player 1's bag
        puts "\tPutting die in Player 1's bag"
        player1.move_all(p1_hand)
        # ensure randomizer is in bag and no longer in hand
        puts "\t\tNum randomizers in Player 1's hand" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{p1_hand.randomizers.length}"
        puts "\t\tNum randomizers in Player 1's bag" + " EXPECTED: ".blue + "1;" + " RECEIVED: ".blue + "#{player1.bag.randomizers.length}"
        assert_equal(player1.bag.randomizers.count, 1, "Player 1's bag should have 1 die")
        assert_equal(p1_hand.randomizers, [], "Player 1's hand should be empty after moving die to bag")

        # transfer die from Player 1's bag to their cup
        puts "\tTransferring the die from Player 1's bag to their cup"
        player1.load
        puts "\t\tNum randomizers in Player 1's bag" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{player1.bag.randomizers.length}"
        puts "\t\tNum randomizers in Player 1's cup" + " EXPECTED: ".blue + "1;" + " RECEIVED: ".blue + "#{player1.cup.randomizers.length}"
        assert_equal(player1.bag.randomizers, [], "Player 1's bag should be empty")
        assert_not_equal(player1.cup.randomizers, [], "Player 1's cup should not be empty")

        # Player 1 rolls die in cup
        player1_turn = true
        num_calls = 0
        while player1_turn
            num_calls += 1
            puts "\tRolling die"
            player1.throw
            # test number die rolls
            puts "\t\tNum die rolls" + " EXPECTED: ".blue + "1;" + " RECEIVED: ".blue + "#{num_calls}"
            assert_equal(die.calls, num_calls, "Die should have been rolled #{num_calls} time(s)")
            puts "\t\tSideup value of die is not out of range" + " EXPECTED: ".blue + "true;" + " RECEIVED: ".blue + "#{die.sideup >= 1 && die.sideup <= 6}"
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
        puts "\t\tNum randomizers in Player 1's cup" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{player1.cup.randomizers.length}"
        puts "\t\tNum randomizers in Player 2's hand" + " EXPECTED: ".blue + "1;" + " RECEIVED: ".blue + "#{p2_hand.randomizers.length}"
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
        puts "\t\tPlayer names" + " EXPECTED: ".blue + "Player 1, Player 2;" + " RECEIVED: ".blue + "#{player1.name}, #{player2.name}"
        assert_equal(player1.name, "Player 1", "Player 1 should have name Player 1")
        assert_equal(player2.name, "Player 2", "Player 2 should have name Player 2")
        # create dice for players to share
        puts "\tCreating two dice for Player 1 to store in bag"
        die1 = Die.new(5, :green)
        die2 = Die.new(5, :blue)
        die3 = Die.new(5, :red)
        die4 = Die.new(5, :yellow)
        puts "\t\tDie 1 description" + " EXPECTED: ".blue + "{:sides=>5, :up=>nil, :item=>:die, :colour=>:green}" + " RECEIVED: ".blue + "#{die1.description}"
        puts "\t\tDie 2 description" + " EXPECTED: ".blue + "{:sides=>5, :up=>nil, :item=>:die, :colour=>:blue}" + " RECEIVED: ".blue + "#{die2.description}"
        puts "\t\tDie 3 description" + " EXPECTED: ".blue + "{:sides=>5, :up=>nil, :item=>:die, :colour=>:red}" + " RECEIVED: ".blue + "#{die3.description}"
        puts "\t\tDie 4 description" + " EXPECTED: ".blue + "{:sides=>5, :up=>nil, :item=>:die, :colour=>:yellow}" + " RECEIVED: ".blue + "#{die4.description}"
        assert({:sides=>5, :up=>nil, :item=>:die, :colour=>:green} == die1.description, "Die is missing necessary attributes")
        assert({:sides=>5, :up=>nil, :item=>:die, :colour=>:blue} == die2.description, "Die is missing necessary attributes")
        assert({:sides=>5, :up=>nil, :item=>:die, :colour=>:red} == die3.description, "Die is missing necessary attributes")
        assert({:sides=>5, :up=>nil, :item=>:die, :colour=>:yellow} == die4.description, "Die is missing necessary attributes")

        # put dice in Player 1's hand
        puts "\tPutting dice in Player 1's hand"
        p1_hand = Hand.new
        randomizers = [die4, die1, die2, die3]
        p1_hand.store_all(randomizers)
        puts "\t\tNum randomizers in Player 1's hand" + " EXPECTED: ".blue + "4;" + " RECEIVED: ".blue + "#{p1_hand.randomizers.length}"
        assert(p1_hand.randomizers.length == 4, "Player 1's hand should have 4 dice")

        # put dice in Player 1's shared bag
        puts "\tPlacing dice in Player 1's bag"
        player1.move_all(p1_hand)
        # ensure randomizer is in bag and no longer in hand
        puts "\t\tNum randomizers in Player 1's hand" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{p1_hand.randomizers.length}"
        puts "\t\tNum randomizers in Player 1's bag" + " EXPECTED: ".blue + "4;" + " RECEIVED: ".blue + "#{player1.bag.randomizers.length}"
        assert_equal(p1_hand.randomizers, [], "Player 1's hand should be empty after moving dice to bag")
        assert_equal(player1.bag.randomizers.count, 4, "Player 1's bag should have 4 dice")

        # put die in Player 1's cup
        puts "\tRandomly picking and placing one die in Player 1's cup"
        player1.load_some({}, 1)
        # ensure randomizer is in bag and no longer in hand
        puts "\t\tNum randomizers in Player 1's bag" + " EXPECTED: ".blue + "3;" + " RECEIVED: ".blue + "#{player1.bag.randomizers.length}"
        puts "\t\tNum randomizers in Player 1's cup" + " EXPECTED: ".blue + "1;" + " RECEIVED: ".blue + "#{player1.cup.randomizers.length}"
        assert_equal(player1.bag.randomizers.count, 3, "Player 1's bag should have 3 dice")
        assert_equal(player1.cup.randomizers.count, 1, "Player 1's cup should have 1 die")

        # setting desired die conditions
        die_criteria = {:up=>3, :colour=>:yellow}
        puts "\tDesired die is yellow and lands on 3"

        # Player 1 rolls die in cup
        tie_broken = false
        if player1.cup.randomizers[0].colour == die_criteria[:colour]
            puts "\t\tPlayer 1's die is desired colour"
            puts "\tRolling die"
            player1.throw
            # expect die to be rolled once
            puts "\t\tNum die rolls" + " EXPECTED: ".blue + "1;" + " RECEIVED: ".blue + "#{player1.cup.randomizers[0].calls}"
            assert_equal(player1.cup.randomizers[0].calls, 1, "Die should have been rolled 1 time")
            puts "\t\tSideup value of Player 1's die is not out of range" + " EXPECTED: ".blue + "true;" + " RECEIVED: ".blue + "#{player1.cup.randomizers[0].sideup >= 1 && player1.cup.randomizers[0].sideup <= player1.cup.randomizers[0].sides}"
            assert(player1.cup.randomizers[0].sideup >= 1 && player1.cup.randomizers[0].sideup <= player1.cup.randomizers[0].sides, "Die should have a sideup value between 1 and #{player1.cup.randomizers[0].sides}")
            # get results of Player 1's roll
            puts "\t\tPlayer 1's roll result: #{player1.cup.randomizers[0].sideup}"
            if player1.cup.randomizers[0].sideup == die_criteria[:up]
                puts "\t\tPlayer 1's die landed on desired value"
                puts "\tPlayer 1 broke the tie"
                tie_broken = true
            end
        end

        # Player 2's turn
        if tie_broken == false
            puts "\tPlayer 1's die did not match desired description"
            puts "\t\tPlayer 1's die: #{player1.cup.randomizers[0].description}"
            puts "\tPlayer 1's turn is over"

            # Player 1 puts die back in bag and shares bag with Player 2
            puts "\tPlayer 1 places die back in shared bag for Player 2's turn"
            player1.replace
            player2.bag = player1.bag
            puts "\t\tNum randomizers in Player 1's cup" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{player1.cup.randomizers.length}"
            puts "\t\tPlayer 1 and Player 2 are sharing a bag" + " EXPECTED: ".blue + "true;" + " RECEIVED: ".blue + "#{player1.bag == player2.bag}"
            puts "\t\tNum randomizers in shared bag" + " EXPECTED: ".blue + "4;" + " RECEIVED: ".blue + "#{player1.bag.randomizers.length}"
            assert_equal(player1.cup.randomizers.length, 0, "Player 1's cup should be empty")
            assert_equal(player1.bag, player2.bag, "Player 1 and Player 2 should have the same bag")
            assert_equal(player1.bag.randomizers.length, 4, "Player 1's bag should have 4 dice")
            assert_equal(player2.bag.randomizers.length, 4, "Player 2's bag should have 4 dice")
        end
    end

end


class TestUnusedMethods < Test::Unit::TestCase

    # checking unused Coin methods
    def test_coin_methods
        puts "\nTesting unused Coin class methods\n"

        coin = Coin.new 0.25

        puts "\tBefore flipping coin..."
        puts "\t\tcoin.sideup()" + " EXPECTED: ".blue + "nil;" + " RECEIVED: ".blue + "#{coin.sideup == nil ? 'nil' : coin.sideup}"
        assert_equal(coin.sideup(), nil, "coin.sideup should return nil if the coin has not been flipped yet")
        puts "\t\tcoin.calls()" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{coin.calls}"
        assert_equal(coin.denomination, 0.25, "Denomination should be 0.25")
        puts "\t\tcoin.denomination()" + " EXPECTED: ".blue + "0.25;" + " RECEIVED: ".blue + "#{coin.denomination}"
        assert_equal(coin.calls(), 0, "Number of randomizations should be 0 on Coin instatntiation")
        puts "\t\t#{coin.description}"

        puts "\tFlipping coin..."
        coin.flip
        puts "\t\tcoin.sideup()" + " EXPECTED: ".blue + "H or T;" + " RECEIVED: ".blue + "#{coin.sideup}"
        assert_not_nil(coin.sideup(), "coin.sideup() should return :H or :T after coin is flipped")
        puts "\t\tcoin.calls()" + " EXPECTED: ".blue + "1;" + " RECEIVED: ".blue + "#{coin.calls}"
        assert_equal(coin.calls(), 1, "coin.calls() should return 1 since coin.flip was called once")
        puts "\t\t#{coin.description}"
    end

    # checking unused Die methods
    def test_die_methods
        puts "\nTesting unused Die class methods\n"

        die = Die.new(6, :red)

        puts "\tBefore rolling die..."
        puts "\t\tdie.sideup()" + " EXPECTED: ".blue + "nil;" + " RECEIVED: ".blue + "#{die.sideup == nil ? 'nil' : die.sideup}"
        assert_equal(die.sideup(), nil, "die.sideup should return nil if the die has not been rolled yet")
        puts "\t\tdie.sides()" + " EXPECTED: ".blue + "6;" + " RECEIVED: ".blue + "#{die.sides}"
        assert_equal(die.sides(), 6, "die.sideup() should return nil if the die has not been rolled yet")
        puts "\t\tdie.colour()" + " EXPECTED: ".blue + ":red;" + " RECEIVED: ".blue + "#{die.colour}"
        assert_equal(die.colour(), :red, "die.colour() should return :red")
        puts "\t\tdie.calls()" + " EXPECTED: ".blue + "0;" + " RECEIVED: ".blue + "#{die.calls}"
        assert_equal(die.calls, 0, "die.calls() should return 0 on Die instantiation")
        puts "\t\t#{die.description}"

        puts "\tRolling die..."
        die.roll
        puts "\t\tdie.sideup()" + " EXPECTED: ".blue + "1-6;" + " RECEIVED: ".blue + "#{die.sideup}"
        assert_not_nil(die.sideup(), "die.sideup() should return a number between 1 and 6 after die is rolled")
        puts "\t\tdie.calls()" + " EXPECTED: ".blue + "1;" + " RECEIVED: ".blue + "#{die.calls}"
        assert_equal(die.calls(), 1, "die.calls() should return 1 since die.roll was called once")
        puts "\t\t#{die.description}"
    end

    # checking unused Player methods
    def test_player_methods
        puts "\nTesting Player class methods\n"

        # create all players
        puts "\tCreating a player"
        player = Player.new("Player")
        # create player coins
        puts "\tCreating two quarters for player"
        coin1 = Coin.new(0.25)
        coin2 = Coin.new(0.25)

        # put players' coins in their bags
        puts "\tPutting 's coin in Player's bag"
        player.store(coin1)
        player.store(coin2)
        # transfer coins from players' bags to the cup
        puts "\tTransferring Player's coins from their bag to their cup"
        player.load

        # flip all coins three times
        puts "\tFlipping each coin three times"
        sum_values = []
        3.times do
            puts "\t\tFlipping coins..."
            player.throw
            player.cup.randomizers.each do |randomizer|
                puts "\t\t#{randomizer.description}"
            end
            coin1_value = coin2_value = 0
            # convert coin values to 1 or 0
            if coin1.sideup == :H
                coin1_value = 1
            end
            if coin2.sideup == :H
                coin2_value = 1
            end
            # store sum of coin values in array to test
            sum_values << coin1_value + coin2_value
        end
        result_values = [coin1.sideup, coin2.sideup]

        # get results of all coin flips
        puts "\tGetting results of all coin flips"
        puts "\t\tplayer.sum({})" + " EXPECTED: ".blue + "#{sum_values}" + " RECEIVED: ".blue + "#{player.sum({})}"
        assert_equal(player.sum({}), sum_values, "player.sum() should return an array of the sum of all coin flip values for each coin flip")
        puts "\t\tplayer.results({}, 0)" + " EXPECTED: ".blue + "#{result_values}" + " RECEIVED: ".blue + "#{player.results({}, 0)}"
        assert_equal(player.results({}, 0), result_values, "player.results({}. 0) should return an array of all coin flip values for the last coin flip")
    end

    # checking unused Bag methods
    def test_bag_methods
        puts "\nTesting Bag class methods\n"

        # create a player
        puts "\tCreating a player"
        player = Player.new("Player")
        # create player coins
        puts "\tCreating two quarters for player and storing in 'coins' array"
        coin1 = Coin.new(0.25)
        coin2 = Coin.new(0.25)
        coins = [coin1, coin2]

        # put players' coins in their bags
        puts "\tPutting coins in Player's bag"
        player.bag.store_all(coins)
        puts "\t\tNum randomizers in bag" + " EXPECTED: ".blue + "2" + " RECEIVED: ".blue + "#{player.bag.randomizers.length}"
        assert_equal(player.bag.randomizers.length, 2, "Player's bag should have 2 randomizers in it")
        puts "\t\tNum randomizers in 'coins' array" + " EXPECTED: ".blue + "2" + " RECEIVED: ".blue + "#{coins.length}"
        assert_equal(coins.length, 2, "'coins' array should still have 2 randomizers in it")
    end

    # checking unused Hand methods
    def test_hand_methods
        puts "\nTesting Hand class methods\n"

        # create a player
        puts "\tCreating a player"
        player = Player.new("Player")
        # create player coins
        puts "\tCreating two quarters for player and storing in 'coins' array"
        coin1 = Coin.new(0.25)
        coin2 = Coin.new(2)
        coins = [coin1, coin2]
        # creating a hand
        puts "\tCreating a hand"
        hand = Hand.new

        # put coins in player's hand
        puts "\tStoring coins in hand"
        hand.store_all(coins)
        puts "\t\tNum randomizers in hand" + " EXPECTED: ".blue + "2" + " RECEIVED: ".blue + "#{hand.randomizers.length}"
        assert_equal(hand.randomizers.length, 2, "Hand should have 2 randomizers in it")

        # remove last added coin from Hand
        puts "\tRemoving last added coin from hand"
        removed_coin = hand.next()
        puts "\t\tNum randomizers in hand" + " EXPECTED: ".blue + "1" + " RECEIVED: ".blue + "#{hand.randomizers.length}"
        assert_equal(hand.randomizers.length, 1, "Hand should have 1 randomizer in it")
        puts "\t\tRemoved coin description" + " EXPECTED: ".blue + "#{coin2.description}" + " RECEIVED: ".blue + "#{removed_coin.description}"
        assert_equal(removed_coin.description, coin2.description, "Removed coin should be the last coin added to the hand")
    end

end
