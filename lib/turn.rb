class Turn
  attr_reader :player1, :player2, :spoils_of_war, :winning_player, :number_of_spoils

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
    @winning_player = winner
    @number_of_spoils = nil
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
      @winning_player = "No Winner"
    elsif type == :war
      @winning_player = bigger_player_at(2)
    else    # :basic case
      @winning_player = bigger_player_at(0)
    end
  end

  def pile_cards                                    # Refactor with helper methods?
    if type == :war || type == :mutually_assured_destruction
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
    @number_of_spoils = spoils_of_war.length
  end

  def award_spoils
    if type != :mutually_assured_destruction
      pile_cards
      number_of_spoils = spoils_of_war.length
      number_of_spoils.times do
        winning_player.deck.add_card( @spoils_of_war.shift )
      end
    else
      pile_cards

      @spoils_of_war.clear
    end
  end
end
