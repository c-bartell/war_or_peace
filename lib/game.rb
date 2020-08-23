class Game
  #vars: names, players,
  #greeting
  #generate players
  #standard deck
  #turn message
  #game_over
  #start

  attr_reader :player1, :player2

  def initialize
    @player1 = nil
    @player2 = nil
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
end
