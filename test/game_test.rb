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
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_greeting
    expected = "Welcome to War! (or Peace) This game will be played with 52 cards.
The players today are Megan and Aurora.
Type 'GO' to start the game!
------------------------------------------------------------------"
    actual = @game.greeting

    assert_equal expected, actual
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

  # def test_turn_output
  #
  # end

  # def test_continue?
  #
  # end

  # def test_game_over
  #
  # end

  # def test_start
  #
  # end
end
