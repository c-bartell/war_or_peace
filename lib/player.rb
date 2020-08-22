class Player                    # Add in Player#remove_card(int) and propagate to dependants? Also Player#rank_of_card_at(index) and Player#add_card
  attr_reader :name, :deck

  def initialize(name, deck)
    @name = name
    @deck = deck
  end

  def has_lost?
    if deck.cards != []
      false
    else
      true
    end
  end
end
