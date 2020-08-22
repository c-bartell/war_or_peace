class Turn
  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
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
end
