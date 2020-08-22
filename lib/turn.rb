class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if ( player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) ) && ( player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2) )
      :mutually_assured_destruction
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
      :war
    else
      :basic
    end
  end

  def bigger_player_at(index)
    players = [player1, player2].sort_by { |player| player.deck.rank_of_card_at(index) }
    players.last
  end

  def winner
    if type == :mutually_assured_destruction
      "No Winner"
    elsif type == :war
      bigger_player_at(2)
    else    # :basic case
      bigger_player_at(0)
    end
  end

  def pile_cards
    if type == :mutually_assured_destruction
      3.times do
        player1.deck.remove_card
        player2.deck.remove_card
      end
    elsif type == :war
      3.times do
        @spoils_of_war << player1.deck.remove_card
      end
      3.times do
        @spoils_of_war << player2.deck.remove_card
      end
    else
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
    end
  end

  # def award_spoils
  #
  # end
end
