require_relative 'movement_non_jump'
require_relative 'movement_jump'

class ChessPiece
  attr_reader :owner, :color, :symbol
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
      make_straight_path_up(coord_x, coord_y, max_moves)
    else
      make_straight_path_down(coord_x, coord_y, max_moves)
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
    directions = %w[up down left right]
    directions.map { |path_name| send("make_straight_path_#{path_name}", coord_x, coord_y, max_moves) }
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
    directions = %w[upleft upright lowleft lowright]
    directions.map { |path_name| send("make_straight_path_#{path_name}", coord_x, coord_y, max_moves) }
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
    directions = %w[horizontal vertical]
    directions.map { |path_name| send("make_jump_path_#{path_name}", coord_x, coord_y) }
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
    directions = %w[up down left right upleft upright lowleft lowright]
    directions.map { |path_name| send("make_straight_path_#{path_name}", coord_x, coord_y, max_moves) }
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
    directions = %w[up down left right upleft upright lowleft lowright]
    directions.map { |path_name| send("make_straight_path_#{path_name}", coord_x, coord_y, max_moves) }
  end
end
