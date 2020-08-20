require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'

class DeckTest < Minitest::Test
  def cards_setup
    card_1 = Card.new(:diamond, 'Queen', 12)
    card_2 = Card.new(:spade, '3', 3)
    card_3 = Card.new(:heart, 'Ace', 14)
    cards = [card_1, card_2, card_3]
  end

  def test_it_exists
    cards = cards_setup
    deck = Deck.new(cards)
    assert_instance_of Deck, deck
  end

  def test_it_has_cards
    cards = cards_setup
    deck = Deck.new(cards.dup)
    assert_equal cards, deck.cards
  end

  def test_rank_of_card_at
    cards = cards_setup
    deck = Deck.new(cards)
    assert_equal 12, deck.rank_of_card_at(0)
    assert_equal 3, deck.rank_of_card_at(1)
    assert_equal 14, deck.rank_of_card_at(2)
  end

  def test_high_ranking_cards
    cards = cards_setup
    deck = Deck.new(cards.dup)
    assert_equal [cards[0], cards[2]], deck.high_ranking_cards
  end

  def test_percent_high_ranking
    cards = cards_setup
    deck = Deck.new(cards)
    assert_equal 66.67, deck.percent_high_ranking
  end

  def test_remove_card
    cards = cards_setup
    deck = Deck.new(cards.dup)

    assert_equal cards, deck.cards
    assert_equal cards[0], deck.remove_card
    assert_equal [cards[1], cards[2]], deck.cards
  end
end
