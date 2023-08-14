module ValidMove
  def self.a_chesspiece?(tile)
    tile.is_a?(ChessPiece)
  end

  def self.matching_colors?(player, piece)
    player.color == piece.color
  end

  def self.within_piece_path?(board, piece, destination)
    is_knight = piece.is_a?(Knight)
    unfiltered_paths = piece.generate_paths
    filtered_paths = unfiltered_paths.map do |path|
      MovePathStop.determine_path_stop(board, path, piece.color, is_knight)
    end
    filtered_paths.any? { |path| path.include(destination) }
  end

  def self.move_results_in_check?(board, piece_to_move, destination)
    board_copy = board.map { |row| row.clone.map(&:clone) }
    origin_row, origin_col = piece_to_move.current_coordinates
    dest_row, dest_col = destination
    board_copy[origin_row][origin_col] = ' '
    board_copy[dest_row][dest_col] = piece_to_move
    Check.king_in_check?(piece_to_move.color, board_copy)
  end
end
