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

module MovementNonJump
  def all_moves_horizontal(coord_x, coord_y, max_moves_per_side)
    possible_coordinates = []
    [-1, 1].each do |shift|
      current = coord_x
      max_moves_per_side.times do
        current += shift
        possible_coordinates << [current, coord_y]
      end
    end
    possible_coordinates.filter { |coords_x, _coords_y| coords_x.between?(1, 8) }
  end

  def all_moves_vertical(coord_x, coord_y, max_moves_per_side)
    possible_coordinates = []
    [-1, 1].each do |shift|
      current = coord_y
      max_moves_per_side.times do
        current += shift
        possible_coordinates << [coord_x, current]
      end
    end
    possible_coordinates.filter { |_coords_x, coords_y| coords_y.between?(1, 8) }
  end

  def all_moves_upper_right(coord_x, coord_y, max_moves)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_moves.times do
      coords.map! { |coord| coord + 1 }
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(1, 8) && coords_y.between?(1, 8) }
  end

  def all_moves_lower_left(coord_x, coord_y, max_moves)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_moves.times do
      coords.map! { |coord| coord - 1 }
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(1, 8) && coords_y.between?(1, 8) }
  end

  def all_moves_upper_left(coord_x, coord_y, max_moves)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_moves.times do
      coords[0] -= 1
      coords[1] += 1
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(1, 8) && coords_y.between?(1, 8) }
  end

  def all_moves_lower_right(coord_x, coord_y, max_moves)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_moves.times do
      coords[0] += 1
      coords[1] -= 1
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(1, 8) && coords_y.between?(1, 8) }
  end
end

class Rook < ChessPiece
  include MovementNonJump

  # forgot to add that this was just a test
  def all_possible_moves
    coord_x, coord_y = @current_coordinates
    all_possible_moves = []
    max_moves = 7
    all_moves_horizontal(coord_x, coord_y, max_moves).each { |coord| all_possible_moves << coord }
    all_moves_vertical(coord_x, coord_y, max_moves).each { |coord| all_possible_moves << coord }
    all_possible_moves
  end
end

class Bishop < ChessPiece
end

class Horse < ChessPiece
end

class Queen < ChessPiece
end

class King < ChessPiece
end