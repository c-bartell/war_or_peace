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

    # @basic_deck_1 = Deck.new([@card_1, @card_2, @card_5, @card_8])
    # @basic_deck_2 = Deck.new([@card_3, @card_4, @card_6, @card_7])
    # @war_deck_1   = Deck.new([@card_, @card, @card, @card])
    # @war_deck_2   = Deck.new([@card, @card, @card, @card])
    # @m_a_d_deck_1 = Deck.new([@card, @card, @card, @card])
    # @m_a_d_deck_2 = Deck.new([@card, @card, @card, @card])


  end
end
