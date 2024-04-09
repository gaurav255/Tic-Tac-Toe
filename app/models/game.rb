class Game
  attr_accessor :board, :winner

  def initialize(board = nil, winner = nil)
    @board = board || Array.new(3) { Array.new(3) }
    @winner = winner
  end

  def make_move(row, col, player)
    return false if @board[row][col] || row.negative? || col.negative? || row > 2 || col > 2
    @board[row][col] = player
    @winner = player if check_winner(player)
    true
  end

  def game_over?
    @board.flatten.none?(&:nil?) || !@winner.nil?
  end

  private

  def check_winner(player)
    winning_combinations.any? do |combination|
      combination.all? { |row, col| @board[row][col] == player }
    end
  end

  def winning_combinations
	  rows = (0..2).map { |row| (0..2).map { |col| [row, col] } }
	  cols = (0..2).map { |col| (0..2).map { |row| [row, col] } }
	  diags = [[[0, 0], [1, 1], [2, 2]], [[0, 2], [1, 1], [2, 0]]]
	  rows + cols + diags
	end

end
