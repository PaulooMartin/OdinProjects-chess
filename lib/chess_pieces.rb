require_relative 'movement_straight'
require_relative 'movement_jump'

class ChessPiece
  attr_reader :color, :symbol
  attr_accessor :current_coordinates

  def initialize(color, starting_coordinates)
    @color = color
    @current_coordinates = starting_coordinates
    @moved = false
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
    else self.new(color, coordinates)
    end
  end

  def can_attack?(piece); end
end

class Pawn < ChessPiece
  def initialize(owner, starting_coordinates)
    super(owner, starting_coordinates)
    if @color == 'light'
      @moved = starting_coordinates[0] != 1
      @symbol = "\u2659"
    else
      @moved = starting_coordinates[0] != 6
      @symbol = "\u265F"
    end
  end

  def generate_paths
    coord_x, coord_y = @current_coordinates
    max_distance = @moved ? 1 : 2
    if @color == 'light'
      [MovementStraight.up(coord_x, coord_y, max_distance)]
    else
      [MovementStraight.down(coord_x, coord_y, max_distance)]
    end
  end
end

class Rook < ChessPiece
  def initialize(owner, starting_coordinates)
    super(owner, starting_coordinates)
    @symbol = @color == 'light' ? "\u2656" : "\u265C"
  end

  def generate_paths
    coord_x, coord_y = @current_coordinates
    max_distance = 7
    up = MovementStraight.up(coord_x, coord_y, max_distance)
    down = MovementStraight.down(coord_x, coord_y, max_distance)
    left = MovementStraight.left(coord_x, coord_y, max_distance)
    right = MovementStraight.right(coord_x, coord_y, max_distance)
    [up, down, left, right]
  end
end

class Bishop < ChessPiece
  def initialize(owner, starting_coordinates)
    super(owner, starting_coordinates)
    @symbol = @color == 'light' ? "\u2657" : "\u265D"
  end

  def generate_paths
    coord_x, coord_y = @current_coordinates
    max_distance = 7
    upleft = MovementStraight.upleft(coord_x, coord_y, max_distance)
    upright = MovementStraight.upright(coord_x, coord_y, max_distance)
    lowleft = MovementStraight.lowleft(coord_x, coord_y, max_distance)
    lowright = MovementStraight.lowright(coord_x, coord_y, max_distance)
    [upleft, upright, lowleft, lowright]
  end
end

class Knight < ChessPiece
  def initialize(owner, starting_coordinates)
    super(owner, starting_coordinates)
    @symbol = @color == 'light' ? "\u2658" : "\u265E"
  end

  def generate_paths
    coord_x, coord_y = @current_coordinates
    horizontal = MovementJump.horizontal(coord_x, coord_y)
    vertical = MovementJump.vertical(coord_x, coord_y)
    [horizontal, vertical]
  end
end

class Queen < ChessPiece
  def initialize(owner, starting_coordinates)
    super(owner, starting_coordinates)
    @symbol = @color == 'light' ? "\u2655" : "\u265B"
  end

  def generate_paths
    coord_x, coord_y = @current_coordinates
    max_distance = 7
    up = MovementStraight.up(coord_x, coord_y, max_distance)
    down = MovementStraight.down(coord_x, coord_y, max_distance)
    left = MovementStraight.left(coord_x, coord_y, max_distance)
    right = MovementStraight.right(coord_x, coord_y, max_distance)
    upleft = MovementStraight.upleft(coord_x, coord_y, max_distance)
    upright = MovementStraight.upright(coord_x, coord_y, max_distance)
    lowleft = MovementStraight.lowleft(coord_x, coord_y, max_distance)
    lowright = MovementStraight.lowright(coord_x, coord_y, max_distance)
    [up, down, left, right, upleft, upright, lowleft, lowright]
  end
end

class King < ChessPiece
  def initialize(owner, starting_coordinates)
    super(owner, starting_coordinates)
    @symbol = @color == 'light' ? "\u2654" : "\u265A"
  end

  def generate_paths
    coord_x, coord_y = @current_coordinates
    max_distance = 1
    up = MovementStraight.up(coord_x, coord_y, max_distance)
    down = MovementStraight.down(coord_x, coord_y, max_distance)
    left = MovementStraight.left(coord_x, coord_y, max_distance)
    right = MovementStraight.right(coord_x, coord_y, max_distance)
    upleft = MovementStraight.upleft(coord_x, coord_y, max_distance)
    upright = MovementStraight.upright(coord_x, coord_y, max_distance)
    lowleft = MovementStraight.lowleft(coord_x, coord_y, max_distance)
    lowright = MovementStraight.lowright(coord_x, coord_y, max_distance)
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
    coord_x, coord_y = @current_coordinates
    max_distance = 7
    up = MovementStraight.up(coord_x, coord_y, max_distance)
    down = MovementStraight.down(coord_x, coord_y, max_distance)
    left = MovementStraight.left(coord_x, coord_y, max_distance)
    right = MovementStraight.right(coord_x, coord_y, max_distance)
    [up, down, left, right]
  end

  def attacker_paths_updiagonals
    coord_x, coord_y = @current_coordinates
    max_distance = 7
    upleft = MovementStraight.upleft(coord_x, coord_y, max_distance)
    upright = MovementStraight.upright(coord_x, coord_y, max_distance)
    [upleft, upright]
  end

  def attacker_paths_downdiagonals
    coord_x, coord_y = @current_coordinates
    max_distance = 7
    lowleft = MovementStraight.lowleft(coord_x, coord_y, max_distance)
    lowright = MovementStraight.lowright(coord_x, coord_y, max_distance)
    [lowleft, lowright]
  end

  def attacker_paths_knight
    coord_x, coord_y = @current_coordinates
    horizontal = MovementJump.horizontal(coord_x, coord_y)
    vertical = MovementJump.vertical(coord_x, coord_y)
    [horizontal, vertical]
  end
end
