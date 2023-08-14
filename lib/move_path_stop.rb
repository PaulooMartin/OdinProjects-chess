module MovePathStop
  def self.determine_path_stop(board, unfiltered_path, origin_color, knight = false)
    filtered_path = []

    unfiltered_path.each do |row, column|
      tile_occupant = board[row][column]
      filtered_path << [row, column]
      if tile_occupant.is_a?(ChessPiece)
        filtered_path.pop if tile_occupant.color == origin_color
        break unless knight
      end
    end

    filtered_path
  end
end
