require 'move_path_stop'
# the 'requires' below is used to make the testing easier
# fen for creating the board and chess_pieces is needed by fen
# movement_* for the movement of the pieces
require 'fen'
require 'chess_pieces'
require 'movement_jump'
require 'movement_straight'

# rubocop:disable Metrics/BlockLength
describe 'MovePathStop' do
  # https://www.chessgames.com/perl/chessgame?gid=2358765
  subject(:fen_a) { 'rnbqkbnr/pp2pppp/3p4/2p5/3PP3/5N2/PPP2PPP/RNBQKB1R b KQkq d3 0 3' }
  subject(:fen_b) { 'r1bqkb1r/pp2pppp/2np1n2/6B1/3NP3/2N5/PPP2PPP/R2QKB1R b KQkq - 4 6' }
  subject(:fen_c) { '1rbqr1nk/6Rp/p1pb1p2/3p3P/5B2/2N1Q3/PPP1BPP1/2KR4 w - - 1 19' }

  subject(:piece_placement_a) { Fen.fen_to_game_state(fen_a)[:piece_placement] }
  subject(:piece_placement_b) { Fen.fen_to_game_state(fen_b)[:piece_placement] }
  subject(:piece_placement_c) { Fen.fen_to_game_state(fen_c)[:piece_placement] }

  subject(:board_a) { Fen.fen_board_to_chess_board(piece_placement_a) }
  subject(:board_b) { Fen.fen_board_to_chess_board(piece_placement_b) }
  subject(:board_c) { Fen.fen_board_to_chess_board(piece_placement_c) }

  describe '#self.determine_path_stop' do
    context 'when determining where the path stops in the board' do
      context 'for Knight' do
        it 'returns the correct path' do
          unfiltered_path = [[5, 0], [5, 2], [6, 3]]
          origin_color = 'dark'
          piecename = 'knight'
          filtered_path = MovePathStop.correct_path(board_a, unfiltered_path, origin_color, piecename)
          correct_path = [[5, 0], [5, 2], [6, 3]]
          expect(filtered_path).to eql(correct_path)
        end

        it 'returns the correct path' do
          unfiltered_path = [[2, 1], [4, 1], [2, 5], [4, 5], [5, 2], [5, 4], [1, 2], [1, 4]]
          origin_color = 'light'
          piecename = 'knight'
          filtered_path = MovePathStop.correct_path(board_b, unfiltered_path, origin_color, piecename)
          correct_path = [[2, 1], [4, 1], [2, 5], [4, 5], [5, 2], [5, 4], [1, 4]]
          expect(filtered_path).to eql(correct_path)
        end

        it 'returns the correct path' do
          unfiltered_path = [[6, 4], [5, 5], [5, 7]]
          origin_color = 'dark'
          piecename = 'knight'
          filtered_path = MovePathStop.correct_path(board_c, unfiltered_path, origin_color, piecename)
          correct_path = [[6, 4], [5, 7]]
          expect(filtered_path).to eql(correct_path)
        end
      end

      context 'for pieces with straight pathing' do
        context 'for Pawn' do
          it 'returns the correct path' do
            unfiltered_path = [[3, 2]]
            origin_color = 'dark'
            piecename = 'pawn'
            filtered_path = MovePathStop.correct_path(board_a, unfiltered_path, origin_color, piecename)
            correct_path = [[3, 2], [3, 3]]
            expect(filtered_path).to eql(correct_path)
          end

          it 'returns the correct path' do
            unfiltered_path = [[4, 4]]
            origin_color = 'light'
            piecename = 'pawn'
            filtered_path = MovePathStop.correct_path(board_b, unfiltered_path, origin_color, piecename)
            correct_path = [[4, 4]]
            expect(filtered_path).to eql(correct_path)
          end

          it 'returns the correct path' do
            unfiltered_path = [[2, 0], [3, 0]]
            origin_color = 'light'
            piecename = 'pawn'
            filtered_path = MovePathStop.correct_path(board_b, unfiltered_path, origin_color, piecename)
            correct_path = [[2, 0], [3, 0]]
            expect(filtered_path).to eql(correct_path)
          end
        end

        context 'for Rook' do
          it 'returns the correct path' do
            unfiltered_path = [[0, 6], [0, 5], [0, 4], [0, 3], [0, 2], [0, 1], [0, 0]]
            origin_color = 'light'
            piecename = 'rook'
            filtered_path = MovePathStop.correct_path(board_a, unfiltered_path, origin_color, piecename)
            correct_path = [[0, 6]]
            expect(filtered_path).to eql(correct_path)
          end

          it 'returns the correct path' do
            unfiltered_path = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]]
            origin_color = 'light'
            piecename = 'rook'
            filtered_path = MovePathStop.correct_path(board_b, unfiltered_path, origin_color, piecename)
            correct_path = [[0, 1], [0, 2]]
            expect(filtered_path).to eql(correct_path)
          end

          it 'returns the correct path' do
            unfiltered_path = [[5, 4], [4, 4], [3, 4], [2, 4], [1, 4], [0, 4]]
            origin_color = 'dark'
            piecename = 'rook'
            filtered_path = MovePathStop.correct_path(board_c, unfiltered_path, origin_color, piecename)
            correct_path = [[5, 4], [4, 4], [3, 4], [2, 4]]
            expect(filtered_path).to eql(correct_path)
          end
        end

        context 'for Bishop' do
          it 'returns the correct path' do
            unfiltered_path = [[6, 3], [5, 4], [4, 5], [3, 6], [2, 7]]
            origin_color = 'dark'
            piecename = 'bishop'
            filtered_path = MovePathStop.correct_path(board_a, unfiltered_path, origin_color, piecename)
            correct_path = [[6, 3], [5, 4], [4, 5], [3, 6], [2, 7]]
            expect(filtered_path).to eql(correct_path)
          end

          it 'returns the correct path' do
            unfiltered_path = [[5, 5], [6, 4], [7, 3]]
            origin_color = 'light'
            piecename = 'bishop'
            filtered_path = MovePathStop.correct_path(board_b, unfiltered_path, origin_color, piecename)
            correct_path = [[5, 5]]
            expect(filtered_path).to eql(correct_path)
          end

          it 'returns the correct path' do
            unfiltered_path = [[6, 1], [5, 0]]
            origin_color = 'dark'
            piecename = 'bishop'
            filtered_path = MovePathStop.correct_path(board_c, unfiltered_path, origin_color, piecename)
            correct_path = [[6, 1]]
            expect(filtered_path).to eql(correct_path)
          end
        end
      end
    end
  end
end