require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'

class DeckTest < Minitest::Test
  def cards_setup
    card_1 = Card.new(:diamond, 'Queen', 12)
    card_2 = Card.new(:spade, '3', 3)
    card_3 = Card.new(:heart, 'Ace', 1)
    cards = [card_1, card_2, card_3]
  end

  def test_it_exists
    cards = cards_setup
    deck = Deck.new(cards)
    assert_instance_of Deck, deck
  end

  def test_has_cards
    cards = cards_setup
    deck = Deck.new(cards)
    assert_equal cards, deck.cards
  end
end
