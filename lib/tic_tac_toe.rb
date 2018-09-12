class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2], #horizontal top row
    [3,4,5], #horizontal middle row
    [6,7,8], #horizontal bottom row
    [0,3,6], #vertical first column
    [1,4,7], #vertical second column
    [2,5,8], #vertical third column
    [0,4,8], #top left to bottom right diagnoal
    [2,4,6] #top right to bottom left diagnoal
  ]
  
def initialize(board = nil)
  @board = board || Array.new(9, " ")
end
  
def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end
  
def input_to_index(input)
  input.to_i - 1
end

def move(location, token)
  @board[location.to_i-1] = token
end

def position_taken?(input)
  index = input_to_index(input)
  
  if @board[index] == "O"
    return true
  elsif @board[index] == "X"
    return true
  elsif @board[index] != "X"
    return false
  elsif @board[index] != "O"
    return false
  end
end

def valid_move?(index)
  input = index.to_i
  if !position_taken?(input-1) && input.between?(1,9)
    return true
  else
    return false
  end
end

def turn
  puts "Please enter 1-9:"
  value = gets.strip
  index = input_to_index(value)
  if valid_move?(index) == true
    value = current_player
    move(index, value)
    display_board
  else
    puts "Please enter a valid input"
    turn
  end
end

def turn_count
  @board.count{|token| token == "X" || token == "O"}
end

def current_player
  turn_count % 2 == 0 ? "X" : "O"
end

def won?
  WIN_COMBINATIONS.detect do |combo|
    position(combo[0]) == position(combo[1]) &&
    position(combo[1]) == position(combo[2]) &&
    position_taken?(combo[0])
  end
end

def full?
 @board.all?{|token| token == "X" || token == "O"}
end

def draw?
  won = won?
  if full? && !won
    return true
  else
    return false
  end
end

def over?
    if draw? || won? || full?
      return true
    else
      return false
  end
end

def winner
  if winner = won?
    if @board[winner[0]] == "X"
      return "X"
    elsif @board[winner[0]] == "O"
      return "O"
    end
  else
    return nil
  end
end

def play
  while !over?
    turn
  end
  if won?
    puts "Congratulations #{winner}!"
  elsif draw?
    puts "Cats Game!"
  end
end

end