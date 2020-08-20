require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'

class DeckTest < Minitest::Test
  def setup
    @card_1 = Card.new(:diamond, 'Queen', 12)
    @card_2 = Card.new(:spade, '3', 3)
    @card_3 = Card.new(:heart, 'Ace', 14)
    @card_4 = Card.new(:club, '5', 5)
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
    assert_equal 14, @deck.rank_of_card_at(-1)
    assert_nil @deck.rank_of_card_at(15)
    assert_nil @deck.rank_of_card_at(-20)
  end

  def test_high_ranking_cards
    assert_equal [@card_1, @card_3], @deck.high_ranking_cards

    @deck = Deck.new([@card_2, @card_4])
    assert_equal [], @deck.high_ranking_cards
  end

  def test_percent_high_ranking
    assert_equal 66.67, @deck.percent_high_ranking

    @deck = Deck.new([@card_3, @card_2, @card_4])
    assert_equal 33.33, @deck.percent_high_ranking

    @deck = Deck.new([@card_2, @card_4])
    assert_equal 0.00, @deck.percent_high_ranking

    @deck = Deck.new([@card_1, @card_3])
    assert_equal 100, @deck.percent_high_ranking
  end

  def test_remove_card
    assert_equal [@card_1, @card_2, @card_3], @deck.cards
    assert_equal @card_1, @deck.remove_card
    assert_equal [@card_2, @card_3], @deck.cards
    assert_equal @card_2, @deck.remove_card
    assert_equal [@card_3], @deck.cards
    assert_equal @card_3, @deck.remove_card
    assert_equal [], @deck.cards
    assert_nil @deck.remove_card
  end

  def test_add_card
    assert_equal [@card_1, @card_2, @card_3], @deck.cards

    @deck.add_card(@card_4)
    assert_equal [@card_1, @card_2, @card_3, @card_4], @deck.cards
  end
end
