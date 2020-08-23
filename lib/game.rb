class Game
  attr_reader :player1, :player2, :turn_number

  def initialize(player1 = nil, player2 = nil, turn_number = 1)
    @player1 = player1
    @player2 = player2
    @turn_number = turn_number
  end

  def greeting
    p "Welcome to War! (or Peace) This game will be played with 52 cards.
The players today are #{player1.name} and #{player2.name}.
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

  def run_turn(turn)
    output = nil
    type = turn.type
    turn_string = "Turn #{turn_number}:"

    turn.award_spoils
    num_of_spoils = turn.number_of_spoils

    if type == :mutually_assured_destruction
      output = "#{turn_string} *mutually assured destruction* #{num_of_spoils} cards removed from play"
    elsif type == :war
      winning_player = turn.winning_player.name
      output = "#{turn_string} WAR - #{turn.winning_player.name} won #{num_of_spoils} cards"
    else # :basic
      output = "#{turn_string} #{turn.winning_player.name} won #{num_of_spoils} cards"
    end

    @turn_number += 1
    p output
  end

  def continue?
    if turn_number > 1000000
      false
    elsif player1.has_lost? || player2.has_lost?
      false
    else
      true
    end
  end

  def game_over
    if turn_number > 1000000 || (player1.has_lost? && player2.has_lost?)
      p "---- DRAW ----"
    else
      winner = player1.name if player2.has_lost?
      winner = player2.name if player1.has_lost?
      p "*~*~*~* #{winner} has won the game! *~*~*~*"
    end
  end

  def start
    user_input = ''
    while user_input != 'GO'
      greeting
      user_input = gets.chomp
    end

    if player1 == nil && player2 == nil
      generate_players
    end

    while continue?
      turn = Turn.new(player1, player2)
      run_turn(turn)
    end

    game_over
  end

end
