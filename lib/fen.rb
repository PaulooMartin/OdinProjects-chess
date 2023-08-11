module Fen
  def self.fen_to_game_state(fen)
    separated_fen = fen.split(' ')
    {
      piece_placement: FenComponents.fen_placements_to_board_format(separated_fen[0]),
      side_to_move: separated_fen[1],
      castling_ability: separated_fen[2],
      en_passant_target: separated_fen[3],
      halfmove_clock: separated_fen[4],
      fullmove_clock: separated_fen[5]
    }
  end

  def self.game_state_to_fen(game_state)
    piece_placements = FenComponents.board_format_to_fen_placements(game_state[:piece_placement])
    side_to_move = game_state[:side_to_move]
    castling_ability = game_state[:castling_ability]
    en_passant_target = game_state[:en_passant_target]
    halfmove_clock = game_state[:halfmove_clock]
    fullmove_clock = game_state[:fullmove_clock]
    "#{piece_placements} #{side_to_move} #{castling_ability} #{en_passant_target} #{halfmove_clock} #{fullmove_clock}"
  end

  module FenComponents
    def self.fen_placements_to_board_format(fen_placements)
      fen_rows = fen_placements.split('/').reverse
      row_num = -1
      fen_rows.map do |fen_row|
        row_num += 1
        fen_row_to_board_row(fen_row, row_num)
      end
    end

    def self.fen_row_to_board_row(fen_row, row_num)
      fen_letters = fen_row.split('')
      board_row = []
      col_num = 0
      fen_letters.each do |fen_letter|
        if fen_letter.match?(/[a-zA-Z]/)
          board_row << fen_letter
          col_num += 1
        else
          count = fen_letter.to_i
          col_num += count
          count.times { board_row << ' ' }
        end
      end
      board_row
    end

    def self.board_format_to_fen_placements(board)
      fen = []
      board.each_with_index do |row, _index|
        fen.unshift board_row_to_fen_row(row)
      end
      fen.join('/')
    end

    def self.board_row_to_fen_row(row)
      fen = ''
      blank = 0
      row.each_with_index do |tile, index|
        if tile.match?(/[a-zA-Z]/)
          fen.concat(blank.to_s) if blank.positive?
          fen.concat(tile)
          blank = 0
        else
          blank += 1
        end
        fen << blank.to_s if blank.positive? && (index == row.length - 1)
      end
      fen
    end
  end
end
