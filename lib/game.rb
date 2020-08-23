class Game
  #turn message
  #continue?
  #game_over
  #start

  attr_reader :player1, :player2, :greeting

  def initialize
    @player1 = nil
    @player2 = nil
    @greeting = "Welcome to War! (or Peace) This game will be played with 52 cards.
The players today are Megan and Aurora.
Type 'GO' to start the game!
------------------------------------------------------------------"
  end

  def standard_deck
    suits = [:spade, :heart, :club, :diamond]
    ranks = []

    13.times { |number| ranks << (number + 2) }

    ranks_names_hash = Hash.new

    ranks.each do |rank|
      ranks_names_hash[rank] = rank.to_s
    end

    ranks_names_hash[11] = 'Jack'
    ranks_names_hash[12] = 'Queen'
    ranks_names_hash[13] = 'King'
    ranks_names_hash[14] = 'Ace'

    deck_array = []
    suits.each do |suit|
      ranks_names_hash.each do |rank, name|
        deck_array << Card.new(suit, name, rank)
      end
    end

    deck_array
  end

  def generate_players
    starting_cards = standard_deck.shuffle
    deck1 = Deck.new(starting_cards[0..25])
    deck2 = Deck.new(starting_cards[26..-1])

    @player1 = Player.new("Megan", deck1)
    @player2 = Player.new("Aurora", deck2)
  end
end
