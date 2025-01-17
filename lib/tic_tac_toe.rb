WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 4, 8],
  [2, 4, 6],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

display_board(board)

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
   if (board[index] == " ") || (board[index] == "") || (board[index] == nil)
      return false 
   else
      return true
   end
end

def valid_move?(board, index)
  if index.between?(0, 9) && !position_taken?(board, index)
    return true
  end
end

def turn_count(board)
  counter = 0
  board.each do |spaces|
      if spaces == "X" || spaces == "O"
        counter += 1
      end 
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else
    return "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board)) && display_board(board)
  else 
    input = gets.strip
  end
end

def won?(board)
  if WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
  
    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  
  else
    false
  end
end

def full?(board)
  board.all? { |space| space == "X" || space == "O" }
end

def draw?(board)
    if !won?(board) && full?(board)
      return true
    end
    if WIN_COMBINATIONS[1] || WIN_COMBINATIONS[3] || WIN_COMBINATIONS[4]
      return false
    end
end

def over?(board)
    if draw?(board) || won?(board) || full?(board)
      return true
    else
      return false
    end
end

def winner(board)
  if winning_combo = won?(board) 
    return board[winning_combo[0]]
  end
end

def play(board)
  input = gets.strip
  counter = 0
  until counter == 9
  turn(board)
  counter += 1
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    winner(board) == "X" || winner(board) == "O"
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cat's Game!"
  end
end
