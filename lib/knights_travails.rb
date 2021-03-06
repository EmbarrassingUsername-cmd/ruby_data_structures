# frozen_string_literal: true

# BoardSquares act as nodes in the graph representing the chess board squares valid knight moves generated
class BoardSquare
  attr_reader :position
  attr_accessor :moves

  def initialize(array)
    @position = array
  end

  def valid_moves
    moves = ([-2, 2].product([-1, 1]) + [-1, 1].product([-2, 2])).map { |move| [move, @position].transpose.map(&:sum) }
    moves.select { |move| move[0].between?(0, 7) && move[1].between?(0, 7) }
  end
  # determines valid moves from any node and returns an array to be stored in the node instance
end

# Board @board contains nodes represents full chess board as well as it'#s methods
class Board
  def initialize
    @board = [*0..7].product([*0..7]).each_with_object({}) do |array, hash|
      hash[array] = BoardSquare.new(array)
      hash
    end
    @board.each_value do |board_square|
      board_square.moves = board_square.valid_moves
    end
  end

  def knight_moves(start_position, finish_position)
    queue = []
    queue.push [start_position, [start_position]]
    node_and_move_list = [nil]
    until node_and_move_list[0] == finish_position
      node_and_move_list = queue.shift
      @board[node_and_move_list[0]].moves.each { |move| queue.push([move, node_and_move_list[1] + [move]]) }
    end
    puts "You made it in #{node_and_move_list[1].length - 1} moves! Here's you path:"
    puts node_and_move_list[1].map(&:to_s)
  end
  # level order progression through Board Graph avoids loops if all
end

a = Board.new
a.knight_moves([7, 7], [7, 0])
