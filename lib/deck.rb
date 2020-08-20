class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(index)
    cards[index].rank
  end

  def high_ranking_cards
    cards.select do |card|
      card.rank >= 11
    end
  end

  def percent_high_ranking
    number_of_high_ranking_cards = high_ranking_cards.count.to_f
    total_cards = cards.count.to_f

    percent = (number_of_high_ranking_cards / total_cards) * 100
    percent.round(2)
  end
end
