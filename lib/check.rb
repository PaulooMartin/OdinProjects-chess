module Check
  def self.king_in_check?(color, board)
    king = CheckComponents.find_king_in_board(color, board)
    attacker_paths_map = CheckComponents.get_king_attacker_paths(king, board)
    attacker_paths = attacker_paths_map.values.flatten(1)
    possible_attackers = CheckComponents.get_all_pieces_in_all_paths(attacker_paths, board)
    possible_attackers.any? { |enemy_piece| ValidMove.within_piece_path?(board, enemy_piece, king.current_coordinates) }
  end

  module CheckComponents
    def self.get_king_attacker_paths(king, board)
      attacker_paths_map = king.attacker_all_paths
      attacker_paths_map.each_key do |path_name|
        attacker_paths_map[path_name].map! do |path|
          is_knight = 'knight' if path_name.eql?(:knight)
          MovePathStop.correct_path(board, path, king.color, is_knight)
        end
      end
      attacker_paths_map
    end

    def self.get_all_pieces_in_all_paths(attackers_paths, board)
      all_occupants_inside_paths = attackers_paths.map do |path|
        path.map { |row, column| board[row][column] }
      end
      all_occupants = all_occupants_inside_paths.flatten
      all_occupants.filter { |occupant| occupant.is_a?(ChessPiece) }
    end

    def self.find_king_in_board(color, board)
      board.flatten.find do |tile_occupant|
        tile_occupant.is_a?(King) && tile_occupant.color == color
      end
    end
  end
end