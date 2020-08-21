require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'

class PlayerTest < Minitest::Test
  def setup
    @card_1 = Card.new(:diamond, 'Queen', 12)
    @card_2 = Card.new(:spade, '3', 3)
    @card_3 = Card.new(:heart, 'Ace', 14)
    @deck = Deck.new([@card_1, @card_2, @card_3])
    @player = Player.new('Clarissa', @deck)
  end

  def test_it_exists
    assert_instance_of Player, @player
  end

  def test_it_has_name_and_deck
    assert_equal 'Clarissa', @player.name
    assert_equal [@card_1, @card_2, @card_3], @player.deck
  end

  def test_it_can_lose
    assert_equal false, @player.has_lost?
    @player.deck.remove_card
    assert_equal false, @player.has_lost?
    @player.deck.remove_card
    assert_equal false, @player.has_lost?
    @player.deck.remove_card
    assert @player.has_lost?
  end
end
