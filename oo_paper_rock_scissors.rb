class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def pick_rps
    puts 'Enter your selection (R, P, or S)'
    player_pick = gets.chomp.upcase
    while !['R', 'P', 'S'].include? player_pick
        puts 'Invalid response: Please enter R, P, or S'
        player_pick = gets.chomp.upcase
      end
    print "You chose #{Game::CHOICES[player_pick]} "
    player_pick
  end 
end

class Computer
  def pick_rps
    computer_selection = Game::CHOICES.keys.sample
    puts "and the computer chose #{Game::CHOICES[computer_selection]}."
    computer_selection
  end
end

class Game
  CHOICES = { 'R' => 'Rock', 'P' => 'Paper', 'S' => 'Scissors' }

  def initialize
    system 'clear'
  end

  def display_winning_message(selection)
    if selection == 'P'
      puts "Paper covers Rock."
    elsif selection == 'R'
      puts "Rock breaks Scissors."
    elsif selection == "S"
      puts "Scissors cut Paper."
    end
  end

  def compare_choices(player1_pick, computer1_pick)
    if player1_pick == computer1_pick
      puts 'It\'s a tie!'
    elsif (player1_pick == 'P' && computer1_pick == 'R') || \
          (player1_pick == 'R' && computer1_pick == 'S') || \
          (player1_pick == 'S' && computer1_pick == 'P')
      display_winning_message(player1_pick)
      puts 'You win!'
    else
      display_winning_message(computer1_pick)
      puts 'You lose!'
    end
  end

  def play_again?(player1, computer1)
      puts "Would you like to play another game? (Y or N)"
      replay = gets.chomp.upcase
      while !['Y', 'N'].include? replay
        puts 'Invalid response: Would you like to play again? Y or N'
        replay = gets.chomp.upcase
      end
      if replay == 'N'
        puts "Thanks for playing. See you next time."
      elsif replay == 'Y'
        Game.new.play(player1, computer1)
      end
  end

  def play(player1, computer1)
    puts "Let's get started #{player1.name}."
    compare_choices(player1.pick_rps, computer1.pick_rps)
    play_again?(player1, computer1)
  end

end

system 'clear'
puts "Welcome to Rock, Paper, Scissors!!!"
puts "What's your name?"
name = gets.chomp

# Creating player objects outside of the loop so they aren't
# accumulating with each new game
player1 = Player.new(name)
computer1 = Computer.new

Game.new.play(player1, computer1)
