class Game
  attr_reader :board, :current_player, :player_x, :player_o

  def initialize
    @board = Board.new
    @player_x = Player.new("Player X", "X")
    @player_o = Player.new("Player O", "O")
    @current_player = player_x
  end

  def play
    until game_over?
      board.display
      player_move
      switch_player
    end
    board.display
    puts game_over_message
  end

  private

  def player_move
    move = nil
    until board.valid_move?(move)
      move = current_player.get_move
    end
    board.update(move, current_player.symbol)
  end

  def switch_player
    @current_player = current_player == player_x ? player_o : player_x
  end

  def game_over?
    board.winning_combination? || board.full?
  end

  def game_over_message
    if board.winning_combination?
      "Congratulations, #{current_player == player_x ? player_o.name : player_x.name} wins!"
    else
      "It's a draw!"
    end
  end
end

class Board
  WINNING_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # columns
    [0, 4, 8], [2, 4, 6]              # diagonals
  ]

  def initialize
    @board = Array.new(9, " ")
  end

  def display
    puts "#{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts "--+---+--"
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts "--+---+--"
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
  end

  def update(position, symbol)
    @board[position] = symbol
  end

  def valid_move?(position)
    position.is_a?(Integer) && position.between?(0, 8) && @board[position] == " "
  end

  def winning_combination?
    WINNING_COMBINATIONS.any? do |combination|
      combination.all? { |index| @board[index] == "X" } ||
      combination.all? { |index| @board[index] == "O" }
    end
  end

  def full?
    !@board.include?(" ")
  end
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def get_move
    puts "#{name}, enter a position (0-8):"
    gets.chomp.to_i
  end
end

# Start the game
game = Game.new
game.play
