require_relative 'movement_non_jump'
require_relative 'movement_jump'

class ChessPiece
  attr_reader :color, :symbol
  attr_accessor :current_coordinates

  def initialize(color, starting_coordinates)
    @color = color
    @current_coordinates = starting_coordinates
    @moved = false
  end
end

class Pawn < ChessPiece
  include MovementNonJump

  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @symbol = @color == 'light' ? "\u2659" : "\u265F"
  end

  def all_possible_moves
    coord_x, coord_y = @current_coordinates
    max_moves = @moved ? 1 : 2
    if @color == 'light'
      all_moves_up(coord_x, coord_y, max_moves)
    else
      all_moves_down(coord_x, coord_y, max_moves)
    end
  end
end

class Rook < ChessPiece
  include MovementNonJump

  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @symbol = @color == 'light' ? "\u2656" : "\u265C"
  end

  def all_possible_moves
    coord_x, coord_y = @current_coordinates
    max_moves = 7
    all_moves_horizontal(coord_x, coord_y, max_moves) + all_moves_vertical(coord_x, coord_y, max_moves)
  end
end

class Bishop < ChessPiece
  include MovementNonJump

  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @symbol = @color == 'light' ? "\u2657" : "\u265D"
  end

  def all_possible_moves
    coord_x, coord_y = @current_coordinates
    max_moves = 7
    all_moves_diagonals(coord_x, coord_y, max_moves)
  end
end

class Horse < ChessPiece
  include MovementJump

  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @symbol = @color == 'light' ? "\u2658" : "\u265E"
  end

  def all_possible_moves
    coord_x, coord_y = @current_coordinates
    generate_possible_moves_horizontal(coord_x, coord_y) + generate_possible_moves_vertical(coord_x, coord_y)
  end
end

class Queen < ChessPiece
  include MovementNonJump

  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @symbol = @color == 'light' ? "\u2655" : "\u265B"
  end

  def all_possible_moves
    coord_x, coord_y = @current_coordinates
    max_moves = 7
    horizontal = all_moves_horizontal(coord_x, coord_y, max_moves)
    vertical = all_moves_vertical(coord_x, coord_y, max_moves)
    diagonal = all_moves_diagonals(coord_x, coord_y, max_moves)
    horizontal + vertical + diagonal
  end
end

class King < ChessPiece
  include MovementNonJump
  include MovementJump

  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @symbol = @color == 'light' ? "\u2654" : "\u265A"
  end

  def all_possible_moves
    coord_x, coord_y = @current_coordinates
    max_moves = 1
    horizontal = all_moves_horizontal(coord_x, coord_y, max_moves)
    vertical = all_moves_vertical(coord_x, coord_y, max_moves)
    diagonal = all_moves_diagonals(coord_x, coord_y, max_moves)
    horizontal + vertical + diagonal
  end
end