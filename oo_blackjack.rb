class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def hand
  end
  
  def score
  end
end

class HumanPlayer < Player
  attr_accessor :bet, :purse

  def initialize(name)
    @purse = 500
    @name = name
  end
 
  def place_bet
    puts "You have $#{purse} #{name}."
    puts 'How much would you like to wager this round?'
    @bet = gets.chomp.to_i
    puts "You have bet $#{bet}."
  end

end

class ComputerPlayer < Player
end

class Card
end

class Deck
end

class Game
  @@game_count = 0

  def play_again
    puts "Would you like to play again?"
    response = gets.chomp
    response
  end

  def initialize
    system 'clear'
    if @@game_count < 1
      puts 'Welcome to Blackjack. What\'s your name?'
      name = gets.chomp
      player1 = HumanPlayer.new(name)
    end
    @@game_count += 1
    play(player1)
  end

  def play(player1)
    player1.place_bet
    play(player1) if play_again == 'Y'
  end
end

Game.new
