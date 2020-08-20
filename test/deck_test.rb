require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'

class DeckTest < Minitest::Test
  def setup
    @card_1 = Card.new(:diamond, 'Queen', 12)
    @card_2 = Card.new(:spade, '3', 3)
    @card_3 = Card.new(:heart, 'Ace', 14)
    @deck = Deck.new([@card_1, @card_2, @card_3])
  end

  def test_it_exists
    assert_instance_of Deck, @deck
  end

  def test_it_has_cards
    assert_equal [@card_1, @card_2, @card_3], @deck.cards
  end

  def test_rank_of_card_at
    assert_equal 12, @deck.rank_of_card_at(0)
    assert_equal 3, @deck.rank_of_card_at(1)
    assert_equal 14, @deck.rank_of_card_at(2)
  end

  def test_high_ranking_cards
    assert_equal [@card_1, @card_3], @deck.high_ranking_cards
  end

  def test_percent_high_ranking
    assert_equal 66.67, @deck.percent_high_ranking    # More cases
  end

  def test_remove_card
    assert_equal [@card_1, @card_2, @card_3], @deck.cards
    assert_equal @card_1, @deck.remove_card
    assert_equal [@card_2, @card_3], @deck.cards
  end

  def test_add_card
    new_card = Card.new(:club, '5', 5)
    assert_equal [@card_1, @card_2, @card_3], @deck.cards

    @deck.add_card(new_card)
    assert_equal [@card_1, @card_2, @card_3, new_card], @deck.cards
  end
end
