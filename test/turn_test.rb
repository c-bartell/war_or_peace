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

    @basic_turn = Turn.new(@player_1, @player_2_basic)
    @war_turn_war = Turn.new(@player_1, @player_2_war)
    @mutually_assured_destruction_turn = Turn.new(@player_1, @player_2_mutually_assured_destruction)
  end
end
