require 'check'
require 'move_path_stop'
require 'validmove'
# the 'requires' below is used to make the testing easier
# fen for creating the board and chess_pieces is needed by fen
# move_path_stop & is used by check
require 'fen'
require 'chess_pieces'

# rubocop:disable Metrics/BlockLength
describe 'Check' do
  subject(:fen_a) { '1rb1r1nk/6Rp/p1p2p1P/3p4/5Q2/2N5/PqP1BPP1/2KR4 w - - 0 22' }
  subject(:fen_b) { '1rbqr1nk/6Rp/p1p2p2/3p3P/5b2/2N3Q1/PPP1BPP1/2KR4 w - - 0 20' }
  subject(:fen_c) { 'br3N2/p4pbk/2n1p1p1/8/2Pp4/3P1N2/P4PB1/B3RK2 b - - 0 29' }

  subject(:piece_placement_a) { Fen.fen_to_game_state(fen_a)[:piece_placement] }
  subject(:piece_placement_b) { Fen.fen_to_game_state(fen_b)[:piece_placement] }
  subject(:piece_placement_c) { Fen.fen_to_game_state(fen_c)[:piece_placement] }

  subject(:board_a) { Fen.fen_board_to_chess_board(piece_placement_a) }
  subject(:board_b) { Fen.fen_board_to_chess_board(piece_placement_b) }
  subject(:board_c) { Fen.fen_board_to_chess_board(piece_placement_c) }
  describe '#self.king_in_check?' do
    context 'when checking if the king is in check' do
      it 'returns true' do
        color = 'light'
        result = Check.king_in_check?(color, board_a)
        expect(result).to be(true)
      end

      it 'returns true' do
        color = 'light'
        result = Check.king_in_check?(color, board_b)
        expect(result).to be(true)
      end

      it 'returns true' do
        color = 'dark'
        result = Check.king_in_check?(color, board_c)
        expect(result).to be(true)
      end
    end

    context 'when checking if the king is NOT in check' do
      it 'returns false' do
        color = 'dark'
        result = Check.king_in_check?(color, board_a)
        expect(result).to be(false)
      end

      it 'returns false' do
        color = 'dark'
        result = Check.king_in_check?(color, board_b)
        expect(result).to be(false)
      end

      it 'returns false' do
        color = 'light'
        result = Check.king_in_check?(color, board_c)
        expect(result).to be(false)
      end
    end
  end
end
