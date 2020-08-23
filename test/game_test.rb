require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new

    @card_1 = Card.new(:heart, 'Jack', 11)
    @card_2 = Card.new(:heart, '10', 10)
    @card_3 = Card.new(:heart, '9', 9)
    @card_4 = Card.new(:diamond, 'Jack', 11)
    @card_5 = Card.new(:heart, '8', 8)
    @card_6 = Card.new(:diamond, 'Queen', 12)
    @card_7 = Card.new(:heart, '3', 3)
    @card_8 = Card.new(:diamond, '2', 2)
    @card_9 = Card.new(:diamond, '8', 8)

    @name_1 = 'Megan'
    @name_2 = 'Aurora'

    @deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
    @deck_2_basic = Deck.new([@card_3, @card_4, @card_6, @card_7])
    @deck_2_war = Deck.new([@card_4, @card_3, @card_6, @card_7])
    @deck_2_mutually_assured_destruction = Deck.new([@card_4, @card_3, @card_9, @card_7])

    @player_1 = Player.new(@name_1, @deck_1)
    @player_2_basic = Player.new(@name_2, @deck_2_basic)
    @player_2_war = Player.new(@name_2, @deck_2_war)
    @player_2_mutually_assured_destruction = Player.new(@name_2, @deck_2_mutually_assured_destruction)

    @turn_basic = Turn.new(@player_1, @player_2_basic)
    @turn_war = Turn.new(@player_1, @player_2_war)
    @turn_mutually_assured_destruction = Turn.new(@player_1, @player_2_mutually_assured_destruction)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_greeting
    expected = "Welcome to War! (or Peace) This game will be played with 52 cards.
The players today are Megan and Aurora.
Type 'GO' to start the game!
------------------------------------------------------------------"
    @game.generate_players

    assert_equal expected, @game.greeting
  end

  def test_standard_deck
    test_card_1 = Card.new(:spade, 'Ace', 14)
    test_card_2 = Card.new(:heart, '4', 4)
    test_card_3 = Card.new(:club, 'King', 13)
    test_card_4 = Card.new(:diamond, '7', 7)

    test_deck = @game.standard_deck

    assert_equal 52, test_deck.length

    test_deck.each { |card| assert_instance_of Card, card }

    assert_equal test_card_1.suit, test_deck[12].suit
    assert_equal test_card_1.value, test_deck[12].value
    assert_equal test_card_1.rank, test_deck[12].rank
    assert_equal test_card_2.suit, test_deck[15].suit
    assert_equal test_card_2.value, test_deck[15].value
    assert_equal test_card_2.rank, test_deck[15].rank
    assert_equal test_card_3.suit, test_deck[37].suit
    assert_equal test_card_3.value, test_deck[37].value
    assert_equal test_card_3.rank, test_deck[37].rank
    assert_equal test_card_4.suit, test_deck[44].suit
    assert_equal test_card_4.value, test_deck[44].value
    assert_equal test_card_4.rank, test_deck[44].rank
  end

  def test_generate_players
    assert_nil @game.player1
    assert_nil @game.player2

    @game.generate_players

    assert_equal "Megan", @game.player1.name
    assert_equal "Aurora", @game.player2.name
    assert_equal 26, @game.player1.deck.cards.length
    assert_equal 26, @game.player2.deck.cards.length
  end

  def test_run_turn
    m_a_d_expected = "Turn 1: *mutually assured destruction* 6 cards removed from play"
    assert_equal m_a_d_expected, @game.run_turn(@turn_mutually_assured_destruction)

    setup
    war_expected = "Turn 1: WAR - Aurora won 6 cards"
    assert_equal war_expected, @game.run_turn(@turn_war)

    setup
    basic_expected = "Turn 1: Megan won 2 cards"
    assert_equal basic_expected, @game.run_turn(@turn_basic)
    assert_equal 2, @game.turn_number
  end

  def test_continue?
    game_run_out_clock = Game.new(@player_1, @player_2_basic, 1000000)
    assert game_run_out_clock.continue?
    game_run_out_clock.run_turn(Turn.new(game_run_out_clock.player1, game_run_out_clock.player2))
    assert_equal false, game_run_out_clock.continue?

    game_draw = Game.new(Player.new("Chaz", Deck.new([])), Player.new("Una", Deck.new([])))
    assert_equal false, game_draw.continue?

    game_someone_lost = Game.new(@player_1, Player.new("Chaz", Deck.new([])))
    assert_equal false, game_someone_lost.continue?

    game_continue = Game.new(@player_1, @player_2_basic)
    assert game_continue.continue?
  end

  def test_game_over
    game_someone_lost = Game.new(@player_1, Player.new("Chaz", Deck.new([])))
    assert_equal "*~*~*~* Megan has won the game! *~*~*~*", game_someone_lost.game_over

    game_run_out_clock = Game.new(@player_1, @player_2_basic, 1000001)
    assert_equal "---- DRAW ----", game_run_out_clock.game_over

    game_draw = Game.new(Player.new("Chaz", Deck.new([])), Player.new("Una", Deck.new([])))
    assert_equal "---- DRAW ----", game_draw.game_over
  end

  # def test_start
  # make a generate_players_unshuffled
  # ie known game pattern, look for certain events
  # dummy decks for draw, 1000000 turns, wins, etc
  # end
end
