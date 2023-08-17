require_relative 'movement_straight'
require_relative 'movement_jump'

class ChessPiece
  attr_reader :color, :symbol
  attr_accessor :current_coordinates

  def initialize(color, starting_coordinates)
    @color = color
    @current_coordinates = starting_coordinates
    @symbol = nil
  end

  def self.create_piece(fen_letter, coordinates)
    color = fen_letter.match?(/[A-Z]/) ? 'light' : 'dark'
    case fen_letter.downcase
    when 'p' then Pawn.new(color, coordinates)
    when 'n' then Knight.new(color, coordinates)
    when 'b' then Bishop.new(color, coordinates)
    when 'r' then Rook.new(color, coordinates)
    when 'q' then Queen.new(color, coordinates)
    when 'k' then King.new(color, coordinates)
    else new(color, coordinates)
    end
  end

  private

  def current_row
    @current_coordinates[0]
  end

  def current_col
    @current_coordinates[1]
  end
end

class Pawn < ChessPiece
  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @symbol = @color == 'light' ? "\u2659" : "\u265F"
  end

  def generate_paths
    if @color == 'light'
      max_distance = current_row == 1 ? 2 : 1
      [MovementStraight.up(current_row, current_col, max_distance)]
    else
      max_distance = current_row == 6 ? 2 : 1
      [MovementStraight.down(current_row, current_col, max_distance)]
    end
  end
end

class Rook < ChessPiece
  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @symbol = @color == 'light' ? "\u2656" : "\u265C"
  end

  def generate_paths
    max_distance = 7
    up = MovementStraight.up(current_row, current_col, max_distance)
    down = MovementStraight.down(current_row, current_col, max_distance)
    left = MovementStraight.left(current_row, current_col, max_distance)
    right = MovementStraight.right(current_row, current_col, max_distance)
    [up, down, left, right]
  end
end

class Bishop < ChessPiece
  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @symbol = @color == 'light' ? "\u2657" : "\u265D"
  end

  def generate_paths
    max_distance = 7
    upleft = MovementStraight.upleft(current_row, current_col, max_distance)
    upright = MovementStraight.upright(current_row, current_col, max_distance)
    lowleft = MovementStraight.lowleft(current_row, current_col, max_distance)
    lowright = MovementStraight.lowright(current_row, current_col, max_distance)
    [upleft, upright, lowleft, lowright]
  end
end

class Knight < ChessPiece
  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @symbol = @color == 'light' ? "\u2658" : "\u265E"
  end

  def generate_paths
    horizontal = MovementJump.horizontal(current_row, current_col)
    vertical = MovementJump.vertical(current_row, current_col)
    [horizontal, vertical]
  end
end

class Queen < ChessPiece
  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @symbol = @color == 'light' ? "\u2655" : "\u265B"
  end

  def generate_paths
    max_distance = 7
    up = MovementStraight.up(current_row, current_col, max_distance)
    down = MovementStraight.down(current_row, current_col, max_distance)
    left = MovementStraight.left(current_row, current_col, max_distance)
    right = MovementStraight.right(current_row, current_col, max_distance)
    upleft = MovementStraight.upleft(current_row, current_col, max_distance)
    upright = MovementStraight.upright(current_row, current_col, max_distance)
    lowleft = MovementStraight.lowleft(current_row, current_col, max_distance)
    lowright = MovementStraight.lowright(current_row, current_col, max_distance)
    [up, down, left, right, upleft, upright, lowleft, lowright]
  end
end

class King < ChessPiece
  def initialize(color, starting_coordinates)
    super(color, starting_coordinates)
    @symbol = @color == 'light' ? "\u2654" : "\u265A"
  end

  def generate_paths
    max_distance = 1
    up = MovementStraight.up(current_row, current_col, max_distance)
    down = MovementStraight.down(current_row, current_col, max_distance)
    left = MovementStraight.left(current_row, current_col, max_distance)
    right = MovementStraight.right(current_row, current_col, max_distance)
    upleft = MovementStraight.upleft(current_row, current_col, max_distance)
    upright = MovementStraight.upright(current_row, current_col, max_distance)
    lowleft = MovementStraight.lowleft(current_row, current_col, max_distance)
    lowright = MovementStraight.lowright(current_row, current_col, max_distance)
    [up, down, left, right, upleft, upright, lowleft, lowright]
  end

  def attacker_all_paths
    attacker_paths = {}
    %i[cross updiagonals downdiagonals knight].each do |path_name|
      attacker_paths[path_name] = send("attacker_paths_#{path_name}")
    end
    attacker_paths
  end

  private

  def attacker_paths_cross
    max_distance = 7
    up = MovementStraight.up(current_row, current_col, max_distance)
    down = MovementStraight.down(current_row, current_col, max_distance)
    left = MovementStraight.left(current_row, current_col, max_distance)
    right = MovementStraight.right(current_row, current_col, max_distance)
    [up, down, left, right]
  end

  def attacker_paths_updiagonals
    max_distance = 7
    upleft = MovementStraight.upleft(current_row, current_col, max_distance)
    upright = MovementStraight.upright(current_row, current_col, max_distance)
    [upleft, upright]
  end

  def attacker_paths_downdiagonals
    max_distance = 7
    lowleft = MovementStraight.lowleft(current_row, current_col, max_distance)
    lowright = MovementStraight.lowright(current_row, current_col, max_distance)
    [lowleft, lowright]
  end

  def attacker_paths_knight
    horizontal = MovementJump.horizontal(current_row, current_col)
    vertical = MovementJump.vertical(current_row, current_col)
    [horizontal, vertical]
  end
end
