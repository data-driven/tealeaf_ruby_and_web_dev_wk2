class Board

  def set_board
    piece_placement = { 1 => ' ', 2 => ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' ' }
  end

  def draw(piece_placement)
    system 'clear'
    puts '     |     |     '
    puts "  #{piece_placement[1]}  |  #{piece_placement[2]}  |  #{piece_placement[3]}   "
    puts '     |     |     '
    puts '-----+-----+-----'
    puts '     |     |     '
    puts "  #{piece_placement[4]}  |  #{piece_placement[5]}  |  #{piece_placement[6]}   "
    puts '     |     |     '
    puts '-----+-----+-----'
    puts '     |     |     '
    puts "  #{piece_placement[7]}  |  #{piece_placement[8]}  |  #{piece_placement[9]}   "
    puts '     |     |     '
    puts
  end 

  def empty_positions(board)
    board.keys.select { |position| board[position] == ' '}
  end

  def board_filled?(board)
    empty_positions = board.keys.select { |position| board[position] == ' '}
    if empty_positions == []
      true
    else
      false
    end
  end

end

class HumanPlayer
  def selection(game_board, board)
    
    begin
      puts 'Choose a position that has not been taken.'
      puts '(from 1 to 9) to place a piece:'
      player_selection = gets.chomp
      puts 'Invalid response: please try again.' \
        if !board.empty_positions(game_board).include?(player_selection.to_i) \
        || player_selection != player_selection.to_i.to_s
    end until board.empty_positions(game_board).include?(player_selection.to_i)\
      && player_selection == player_selection.to_i.to_s
    game_board[player_selection.to_i] = 'X'
    board.draw(game_board)
  end
end

class ComputerPlayer
  def selection(game_board, board)
    computer_selection = game_board.select { |key, value| value == ' ' }.to_a.sample(1).flatten[0]
    game_board[computer_selection] = 'O'
    board.draw(game_board)
  end
end

class Game

  def announce_winner(winner)
    puts "We have a winner! #{winner} takes the game." 
  end

  def announce_tie
    puts "It's a tie!"
  end

  def check_winner(game_board)
    winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    winning_lines.each do |line|
      if game_board.values_at(*line).count('X') == 3
        announce_winner ('X')
        return 'winner'
      elsif game_board.values_at(*line).count('O') == 3
        announce_winner('O')
        return 'winner'
      else
        nil
      end
    end
  end

  def board_filled?(board)
    empty_positions = board.keys.select { |position| board[position] == ' '}
    if empty_positions == []
      announce_tie
      return 'tie'
    else
      nil
    end
  end

  def play_again?
    begin 
      puts 'Play another game? Y or N'
      response = gets.chomp.upcase
      puts 'Invalid response: Please try again.' if response != 'Y' && response !='N'
    end until response == 'Y' || response == 'N'
    response
  end

  def play(player1, computer1)
    board = Board.new
    game_board = board.set_board
    board.draw(game_board)

    while check_winner(game_board) != 'winner' && board_filled?(game_board) != 'tie'
      player1.selection(game_board, board) 
      computer1.selection(game_board, board)
    end 

    if play_again? == 'Y'
      play(player1, computer1)
    else
      puts 'Thanks for playing. See you next time.'
    end
  end
end

player1 = HumanPlayer.new
computer1 = ComputerPlayer.new

Game.new.play(player1, computer1)

