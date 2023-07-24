require_relative 'movement_non_jump'
require_relative 'movement_jump'

class ChessPiece
  attr_reader :owner, :color, :symbol
  attr_writer :in_chessboard
  attr_accessor :current_coordinates

  def initialize(owner, starting_coordinates)
    @owner = owner
    @color = @owner.color
    @current_coordinates = starting_coordinates
    @moved = false
  end
end

class Pawn < ChessPiece
  include MovementNonJump

  def initialize(owner, starting_coordinates)
    super(owner, starting_coordinates)
    @symbol = @color == 'light' ? "\u2659" : "\u265F"
  end

  def generate_paths
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

  def initialize(owner, starting_coordinates)
    super(owner, starting_coordinates)
    @symbol = @color == 'light' ? "\u2656" : "\u265C"
  end

  def generate_paths
    coord_x, coord_y = @current_coordinates
    max_moves = 7
    path_up = all_moves_up(coord_x, coord_y, max_moves)
    path_down = all_moves_down(coord_x, coord_y, max_moves)
    path_left = all_moves_left(coord_x, coord_y, max_moves)
    path_right = all_moves_right(coord_x, coord_y, max_moves)
    [path_up, path_down, path_left, path_right]
  end
end

class Bishop < ChessPiece
  include MovementNonJump

  def initialize(owner, starting_coordinates)
    super(owner, starting_coordinates)
    @symbol = @color == 'light' ? "\u2657" : "\u265D"
  end

  def generate_paths
    coord_x, coord_y = @current_coordinates
    max_moves = 7
    path_upleft = all_moves_upper_left(coord_x, coord_y, max_moves)
    path_upright = all_moves_upper_right(coord_x, coord_y, max_moves)
    path_downleft = all_moves_lower_left(coord_x, coord_y, max_moves)
    path_downright = all_moves_lower_right(coord_x, coord_y, max_moves)
    [path_upleft, path_upright, path_downleft, path_downright]
  end
end

class Horse < ChessPiece
  include MovementJump

  def initialize(owner, starting_coordinates)
    super(owner, starting_coordinates)
    @symbol = @color == 'light' ? "\u2658" : "\u265E"
  end

  def generate_paths
    coord_x, coord_y = @current_coordinates
    [generate_possible_moves_horizontal(coord_x, coord_y), generate_possible_moves_vertical(coord_x, coord_y)]
  end
end

class Queen < ChessPiece
  include MovementNonJump

  def initialize(owner, starting_coordinates)
    super(owner, starting_coordinates)
    @symbol = @color == 'light' ? "\u2655" : "\u265B"
  end

  def generate_paths
    coord_x, coord_y = @current_coordinates
    max_moves = 7
    path_up = all_moves_up(coord_x, coord_y, max_moves)
    path_down = all_moves_down(coord_x, coord_y, max_moves)
    path_left = all_moves_left(coord_x, coord_y, max_moves)
    path_right = all_moves_right(coord_x, coord_y, max_moves)
    path_upleft = all_moves_upper_left(coord_x, coord_y, max_moves)
    path_upright = all_moves_upper_right(coord_x, coord_y, max_moves)
    path_downleft = all_moves_lower_left(coord_x, coord_y, max_moves)
    path_downright = all_moves_lower_right(coord_x, coord_y, max_moves)
    [path_up, path_down, path_left, path_right, path_upleft, path_upright, path_downleft, path_downright]
  end
end

class King < ChessPiece
  include MovementNonJump
  include MovementJump

  def initialize(owner, starting_coordinates)
    super(owner, starting_coordinates)
    @symbol = @color == 'light' ? "\u2654" : "\u265A"
  end

  def generate_paths
    coord_x, coord_y = @current_coordinates
    max_moves = 1
    path_up = all_moves_up(coord_x, coord_y, max_moves)
    path_down = all_moves_down(coord_x, coord_y, max_moves)
    path_left = all_moves_left(coord_x, coord_y, max_moves)
    path_right = all_moves_right(coord_x, coord_y, max_moves)
    path_upleft = all_moves_upper_left(coord_x, coord_y, max_moves)
    path_upright = all_moves_upper_right(coord_x, coord_y, max_moves)
    path_downleft = all_moves_lower_left(coord_x, coord_y, max_moves)
    path_downright = all_moves_lower_right(coord_x, coord_y, max_moves)
    [path_up, path_down, path_left, path_right, path_upleft, path_upright, path_downleft, path_downright]
  end
end
