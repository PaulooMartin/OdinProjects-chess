module MovePathStop
  def self.correct_path(board, unfiltered_path, origin_color, piecename = nil)
    return PawnMovement.correct_path(board, unfiltered_path, origin_color) if piecename == 'pawn'

    filtered_path = []
    unfiltered_path.each do |row, column|
      tile_occupant = board[row][column]
      filtered_path << [row, column]
      if tile_occupant.is_a?(ChessPiece)
        filtered_path.pop if tile_occupant.color == origin_color
        break unless piecename == 'knight'
      end
    end

    filtered_path
  end

  module PawnMovement
    def self.correct_path(board, unfiltered_path, origin_color)
      filtered_path = []

      unfiltered_path.each do |row, column|
        tile_occupant = board[row][column]
        filtered_path << [row, column]
        if tile_occupant.is_a?(ChessPiece)
          filtered_path.pop
          break
        end
      end
      filtered_path + capture_tiles(board, unfiltered_path[0], origin_color)
    end

    def self.capture_tiles(board, first_tile_coords, origin_color)
      capture_tiles = []
      row, column = first_tile_coords

      [-1, 1].each do |shift_y|
        tile_occupant = board[row][column + shift_y]
        if tile_occupant.is_a?(ChessPiece) && tile_occupant.color != origin_color
          capture_tiles << [row, column + shift_y]
        end
      end

      capture_tiles
    end
  end
end
