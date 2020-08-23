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
    actual = game.greeting

    assert_equal expected, actual
  end

  def test_standard_deck
    test_card_1 = Card.new(:spade, 'Ace', 14)
    test_card_2 = Card.new(:heart, '4', 4)
    test_card_3 = Card.new(:club, 'King', 13)
    test_card_4 = Card.new(:diamond, '7', 7)

    test_deck = @game.standard_deck

    assert_equal 52, test_deck.length

    test_deck.each do |card|
      assert_instance_of Card, card
    end

    assert_equal test_card_1, test_deck[12]
    assert_equal test_card_1, test_deck[15]
    assert_equal test_card_1, test_deck[37]
    assert_equal test_card_1, test_deck[44]
  end

  def test_generate_players
    game.generate_players

    assert_equal "Megan", @game.player1.name
    assert_equal "Aurora", @game.player2.name
    assert_equal 26, @game.player1.deck.length
    assert_equal 26, @game.player2.deck.length
  end
end
