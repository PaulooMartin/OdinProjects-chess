require 'validmove'
require 'move_path_stop'
require 'fen'
require 'chess_pieces'

# rubocop:disable Metrics/BlockLength
describe 'ValidMove' do
  subject(:fen_a) { 'rnbqkbnr/pp2pppp/3p4/1Bp5/4P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 1 3' }
  subject(:fen_b) { 'rn1qkbnr/pp1Bpppp/3p4/2p5/4P3/5N2/PPPP1PPP/RNBQK2R b KQkq - 0 4' }
  subject(:fen_c) { 'r3k2r/pp2ppbp/2np1np1/q7/2PNP3/1PN2P2/PB4PP/R2QK2R w KQkq - 3 12' }

  subject(:piece_placement_a) { Fen.fen_to_game_state(fen_a)[:piece_placement] }
  subject(:piece_placement_b) { Fen.fen_to_game_state(fen_b)[:piece_placement] }
  subject(:piece_placement_c) { Fen.fen_to_game_state(fen_c)[:piece_placement] }

  subject(:board_a) { Fen.fen_board_to_chess_board(piece_placement_a) }
  subject(:board_b) { Fen.fen_board_to_chess_board(piece_placement_b) }
  subject(:board_c) { Fen.fen_board_to_chess_board(piece_placement_c) }

  describe '#self.within_piece_path?' do
    context 'when determining if destination is within piece\'s correct path' do
      it 'returns true' do
        coords = [7, 3]
        piece_to_test = board_a[coords[0]][coords[1]]
        destination = [6, 3]
        result = ValidMove.within_piece_path?(board_a, piece_to_test, destination)
        expect(result).to be(true)
      end

      it 'returns true' do
        coords = [7, 1]
        piece_to_test = board_b[coords[0]][coords[1]]
        destination = [6, 3]
        result = ValidMove.within_piece_path?(board_b, piece_to_test, destination)
        expect(result).to be(true)
      end

      it 'returns true' do
        coords = [2, 1]
        piece_to_test = board_c[coords[0]][coords[1]]
        destination = [3, 1]
        result = ValidMove.within_piece_path?(board_c, piece_to_test, destination)
        expect(result).to be(true)
      end
    end

    context 'when determining if destination is NOT within piece\'s path' do
      it 'returns false' do
        coords = [7, 2]
        piece_to_test = board_a[coords[0]][coords[1]]
        destination = [6, 2]
        result = ValidMove.within_piece_path?(board_a, piece_to_test, destination)
        expect(result).to be(false)
      end

      it 'returns false' do
        coords = [2, 5]
        piece_to_test = board_b[coords[0]][coords[1]]
        destination = [0, 4]
        result = ValidMove.within_piece_path?(board_b, piece_to_test, destination)
        expect(result).to be(false)
      end

      it 'returns false' do
        coords = [2, 1]
        piece_to_test = board_c[coords[0]][coords[1]]
        destination = [4, 1]
        result = ValidMove.within_piece_path?(board_c, piece_to_test, destination)
        expect(result).to be(false)
      end
    end
  end
end