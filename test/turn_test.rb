require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

def TurnTest < Minitest::Test
  def setup
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
    assert_instance_of Turn, @turn_basic
    assert_instance_of Turn, @turn_war
    assert_instance_of Turn,   @turn_mutually_assured_destruction
  end

  def test_it_has_players
    assert_equal @player_1, @turn_basic.player1
    assert_equal @player_1, @turn_war.player1
    assert_equal @player_1, @turn_mutually_assured_destruction.player1

    assert_equal @player_2_basic, @turn_basic.player2
    assert_equal @player_2_war, @turn_war.player2
    assert_equal @player_2_mutually_assured_destruction, @turn_mutually_assured_destruction.player2
  end

  def test_it_can_determine_type
    assert_equal :basic, @turn_basic.type
    assert_equal :war, @turn_war.type
    assert_equal :mutually_assured_destruction, @turn_mutually_assured_destruction.type
  end

  def test_it_can_determine_winner
    assert_equal @player_1, @turn_basic.winner
    assert_equal @player_2, @turn_war.winner
    assert_equal "No Winner", @turn_mutually_assured_destruction.winner
  end

  def test_it_has_spoils
    assert_equal [], @turn_basic.spoils_of_war
    assert_equal [], @turn_war.spoils_of_war
    assert_equal [], @turn_mutually_assured_destruction.spoils_of_war
  end

  def test_it_piles_cards
    @turn_basic.pile_cards

    assert_equal [@card1, @card_3], @turn_basic.spoils_of_war
    assert_equal [@card_2, @card_5, @card_8], @turn_basic.player1.deck
    assert_equal [@card_4, @card_6, @card_7], @turn_basic.player2.deck

    @turn_war.pile_cards

    assert_equal [@card_1, @card_2, @card_5, @card_4, @card_3, @card_6], @turn_war.spoils_of_war
    assert_equal [@card_8], @turn_war.player1.deck
    assert_equal [@card_7], @turn_war.player2.deck

    @turn_mutually_assured_destruction.pile_cards

    assert_equal [], @turn_mutually_assured_destruction.spoils_of_war
    assert_equal [@card_8], @turn_mutually_assured_destruction.player1.deck
    assert_equal [@card_7], @turn_mutually_assured_destruction.player2.deck
  end

  def test_it_awards_spoils
    @turn_basic.pile_cards

    assert_equal [@card_2, @card_5, @card_8], @turn_basic.player1.deck
    assert_equal [@card_4, @card_6, @card_7], @turn_basic.player2.deck

    @turn_basic.award_spoils

    assert_equal [@card_2, @card_5, @card_8, @card_1, @card_3], @turn_basic.player1.deck
    assert_equal [@card_4, @card_6, @card_7], @turn_basic.player2.deck

    @turn_war.pile_cards

    assert_equal [@card_8], @turn_basic.player1.deck
    assert_equal [@card_7], @turn_basic.player2.deck

    @turn_war.award_spoils

    assert_equal [@card_8], @turn_war.player1.deck
    assert_equal [@card_7, @card_1, @card_2, @card_5, @card_4, @card_3, @card_6], @turn_war.player2.deck

    @turn_mutually_assured_destruction.pile_cards

    assert_equal [@card_8], @turn_mutually_assured_destruction.player1.deck
    assert_equal [@card_7], @turn_mutually_assured_destruction.player2.deck

    @turn_mutually_assured_destruction.award_spoils

    assert_equal [@card_8], @turn_mutually_assured_destruction.player1.deck
    assert_equal [@card_7], @turn_mutually_assured_destruction.player2.deck
  end
end
