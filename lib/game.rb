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
end
