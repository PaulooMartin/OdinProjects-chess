class Chessboard
  def initialize
    @board = Array.new(8) { Array.new(8, nil) }
  end
end

class ChessPiece
  attr_reader :color
  attr_accessor :current_coordinates

  def initialize(color, starting_coordinates)
    @color = color
    @current_coordinates = starting_coordinates
  end
end

class Pawn < ChessPiece
end

class Rook < ChessPiece
end

class Bishop < ChessPiece
end

class Horse < ChessPiece
end

class Queen < ChessPiece
end

class King < ChessPiece
end