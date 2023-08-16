require 'validmove'
require 'move_path_stop'
require 'fen'
require 'chess_pieces'

# rubocop:disable Metrics/BlockLength
describe 'ValidMove' do
  subject(:fen_a) { 'rnbqkbnr/pp2pppp/3p4/2p5/3PP3/5N2/PPP2PPP/RNBQKB1R b KQkq d3 0 3' }
  subject(:fen_b) { 'r1bqkb1r/pp2pppp/2np1n2/6B1/3NP3/2N5/PPP2PPP/R2QKB1R b KQkq - 4 6' }
  subject(:fen_c) { '1rbqr1nk/6Rp/p1pb1p2/3p3P/5B2/2N1Q3/PPP1BPP1/2KR4 w - - 1 19' }

  subject(:piece_placement_a) { Fen.fen_to_game_state(fen_a)[:piece_placement] }
  subject(:piece_placement_b) { Fen.fen_to_game_state(fen_b)[:piece_placement] }
  subject(:piece_placement_c) { Fen.fen_to_game_state(fen_c)[:piece_placement] }

  subject(:board_a) { Fen.fen_board_to_chess_board(piece_placement_a) }
  subject(:board_b) { Fen.fen_board_to_chess_board(piece_placement_b) }
  subject(:board_c) { Fen.fen_board_to_chess_board(piece_placement_c) }

  describe '#self.within_piece_path?' do
    context 'when determining if destination is within piece\'s path' do
      it 'returns true' do
        coords = [7, 3]
        piece_to_test = board_a[coords[0]][coords[1]]
        destination = [4, 0]
        result = ValidMove.within_piece_path?(board_a, piece_to_test, destination)
        expect(result).to be(true)
      end

      it 'returns true' do
        coords = [0, 5]
        piece_to_test = board_b[coords[0]][coords[1]]
        destination = [5, 0]
        result = ValidMove.within_piece_path?(board_b, piece_to_test, destination)
        expect(result).to be(true)
      end

      it 'returns true' do
        coords = [2, 4]
        piece_to_test = board_c[coords[0]][coords[1]]
        destination = [7, 4]
        result = ValidMove.within_piece_path?(board_c, piece_to_test, destination)
        expect(result).to be(true)
      end
    end

    context 'when determining if destination is NOT within piece\'s path' do
      it 'returns false' do
        coords = [7, 3]
        piece_to_test = board_a[coords[0]][coords[1]]
        destination = [7, 4]
        result = ValidMove.within_piece_path?(board_a, piece_to_test, destination)
        expect(result).to be(false)
      end

      it 'returns false' do
        coords = [0, 5]
        piece_to_test = board_b[coords[0]][coords[1]]
        destination = [2, 7]
        result = ValidMove.within_piece_path?(board_b, piece_to_test, destination)
        expect(result).to be(false)
      end

      it 'returns false' do
        coords = [2, 4]
        piece_to_test = board_c[coords[0]][coords[1]]
        destination = [0, 2]
        result = ValidMove.within_piece_path?(board_c, piece_to_test, destination)
        expect(result).to be(false)
      end
    end
  end
end