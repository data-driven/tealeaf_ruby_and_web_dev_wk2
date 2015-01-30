require "pry"

class Player
  attr_accessor :name, :hand, :score

  def initialize(name)
    @name = name
    @hand = []
  end
  
  def display_hand
    puts "#{name}'s Hand:" 
    @hand.each { |value| puts "#{value[0]} of #{value[1]}" }
    puts
  end

  def calculate_score
    @score = 0
    @hand.each do |value| 
      case value[0]
      when 2..10
        @score += value[0]
      when 'Jack', 'King', 'Queen'
        @score += 10
      when 'Ace'
        @score += 11
      end
    end
    @hand.select{ |card| card[0] == 'Ace' }.count.times do
      @score -= 10 if @score > 21
    end
    @score
  end

  def say_score
    puts "#{@name}'s Score: #{calculate_score}"
  end

  def show_info
    system 'clear'
    display_hand
    say_score
    puts
  end

end

class HumanPlayer < Player
  attr_accessor :bet, :purse

  def initialize(name)
    super
    @purse = 500
  end
 
  def place_bet
    puts "You have $#{purse} #{name}."
    puts 'How much would you like to wager this round?'
    @bet = gets.chomp.to_i
    system 'clear'
    puts "You have bet $#{bet}."
    puts
  end

  def hit_or_stay(deck, player, computer)
    loop do
      begin
        puts 'Would you like to stay or hit? (Enter S or H)'
        hit_or_stay = gets.chomp.upcase 
        puts "Invalid entry. Please try again" if !['S', 'H'].include?(hit_or_stay)
      end until hit_or_stay == 'S' || hit_or_stay == 'H'
      deck.deal(player.hand) if hit_or_stay == 'H'
      system 'clear'
      player.show_info
      break if hit_or_stay == 'S' 
    end
  end

end

class ComputerPlayer < Player
  def initialize(name)
    super
  end
end

class Card
  SUITS = ['Clubs', 'Diamaonds', 'Hearts', 'Spades']
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  def get_card_value
  end

end

class Deck < Card
  @@num_decks = 0
  @@game_deck = []
  
  def initialize
    @@num_decks += 1
    @@game_deck = add_deck
    @name = 'deck_' + @@num_decks.to_s
  end

  def add_deck
    @@game_deck = @@game_deck + VALUES.product(SUITS).shuffle
    @@game_deck
  end

  def deal(hand)
    if @@game_deck.length > 0
      hand.push @@game_deck.pop
    else
      add_deck
      deal(hand)
    end
  end


end

class Game
  @@game_count = 0

  def initialize
    system 'clear'
    if @@game_count < 1
      puts 'Welcome to Blackjack. What\'s your name?'
      name = gets.chomp
      player1 = HumanPlayer.new(name)
      computer = ComputerPlayer.new('Computer')
    end
    @@game_count += 1
    play(player1, computer)
  end

  def play_again
    puts "Would you like to play again?"
    response = gets.chomp
    response
  end

  

  def play(player1, computer)
    system 'clear'
    player1.place_bet
    game_deck = Deck.new
    game_deck.deal(player1.hand)
    game_deck.deal(computer.hand)
    computer.display_hand
    game_deck.deal(player1.hand)
    game_deck.deal(computer.hand)
    player1.show_info
    player1.hit_or_stay(game_deck, player1, computer)

    
    play(player1, computer) if play_again == 'Y'
  end
end

Game.new
