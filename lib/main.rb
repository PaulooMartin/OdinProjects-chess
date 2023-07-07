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

module MovementNonJump
  def all_moves_horizontal(coord_x, coord_y, max_moves_per_side)
    all_moves_left(coord_x, coord_y, max_moves_per_side) + all_moves_right(coord_x, coord_y, max_moves_per_side)
  end

  def all_moves_vertical(coord_x, coord_y, max_moves_per_side)
    all_moves_up(coord_x, coord_y, max_moves_per_side) + all_moves_down(coord_x, coord_y, max_moves_per_side)
  end

  def all_moves_diagonals(coord_x, coord_y, max_moves_per_side)
    diagonal_a = all_moves_upper_left(coord_x, coord_y,
                                      max_moves_per_side) + all_moves_lower_right(coord_x, coord_y, max_moves_per_side)
    diagonal_b = all_moves_lower_left(coord_x, coord_y,
                                      max_moves_per_side) + all_moves_upper_right(coord_x, coord_y, max_moves_per_side)
    diagonal_a + diagonal_b
  end

  def all_moves_left(coord_x, coord_y, max_moves)
    possible_coordinates = []
    current = coord_x
    max_moves.times do
      current -= 1
      possible_coordinates << [current, coord_y]
    end
    possible_coordinates.filter { |coords| coords[0].between?(1, 8) }
  end

  def all_moves_right(coord_x, coord_y, max_moves)
    possible_coordinates = []
    current = coord_x
    max_moves.times do
      current += 1
      possible_coordinates << [current, coord_y]
    end
    possible_coordinates.filter { |coords| coords[0].between?(1, 8) }
  end

  def all_moves_up(coord_x, coord_y, max_moves)
    possible_coordinates = []
    current = coord_y
    max_moves.times do
      current += 1
      possible_coordinates << [coord_x, current]
    end
    possible_coordinates.filter { |coords| coords[1].between?(1, 8) }
  end

  def all_moves_down(coord_x, coord_y, max_moves)
    possible_coordinates = []
    current = coord_y
    max_moves.times do
      current -= 1
      possible_coordinates << [coord_x, current]
    end
    possible_coordinates.filter { |coords| coords[1].between?(1, 8) }
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

  def all_moves_lower_left(coord_x, coord_y, max_moves)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_moves.times do
      coords.map! { |coord| coord - 1 }
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

class Pawn < ChessPiece
  include MovementNonJump

  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @moved = false
  end

  def all_possible_moves
    coord_x, coord_y = @current_coordinates
    max_moves = @moved ? 1 : 2
    all_moves_up(coord_x, coord_y, max_moves)
  end
end

class Rook < ChessPiece
  include MovementNonJump

  def all_possible_moves
    coord_x, coord_y = @current_coordinates
    max_moves = 7
    all_moves_horizontal(coord_x, coord_y, max_moves) + all_moves_vertical(coord_x, coord_y, max_moves)
  end
end

class Bishop < ChessPiece
  include MovementNonJump

  def all_possible_moves
    coord_x, coord_y = @current_coordinates
    max_moves = 7
    all_moves_diagonals(coord_x, coord_y, max_moves)
  end
end

class Horse < ChessPiece
  def all_possible_moves
    coord_x, coord_y = @current_coordinates
    generate_possible_moves_horizontal(coord_x, coord_y) + generate_possible_moves_vertical(coord_x, coord_y)
  end

  private

  def generate_possible_moves_horizontal(coord_x, coord_y)
    possible_coordinates = []
    [-2, 2].each do |shift_x|
      [-1, 1].each do |shift_y|
        possible_coordinates << [coord_x + shift_x, coord_y + shift_y]
      end
    end
    possible_coordinates.keep_if { |x, y| x.between?(1, 8) && y.between?(1, 8) }
  end

  def generate_possible_moves_vertical(coord_x, coord_y)
    possible_coordinates = []
    [-1, 1].each do |shift_x|
      [-2, 2].each do |shift_y|
        possible_coordinates << [coord_x + shift_x, coord_y + shift_y]
      end
    end
    possible_coordinates.keep_if { |x, y| x.between?(1, 8) && y.between?(1, 8) }
  end
end

class Queen < ChessPiece
  include MovementNonJump

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

  def all_possible_moves
    coord_x, coord_y = @current_coordinates
    max_moves = 1
    horizontal = all_moves_horizontal(coord_x, coord_y, max_moves)
    vertical = all_moves_vertical(coord_x, coord_y, max_moves)
    diagonal = all_moves_diagonals(coord_x, coord_y, max_moves)
    horizontal + vertical + diagonal
  end
end