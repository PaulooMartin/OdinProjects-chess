require 'fen'
require 'chess_pieces'

# rubocop:disable Metrics/BlockLength
describe 'FEN' do
  # https://www.chessgames.com/perl/chessgame?gid=2358765
  subject(:fen_string_a) { '1rb1r1nk/6Rp/pqp2p1P/3p4/5Q2/2N5/PPP1BPP1/2KR4 b - - 0 21' }
  subject(:fen_string_b) { 'r1bqk2r/pp2bppp/2nppn2/6B1/3NP3/2N5/PPPQ1PPP/R3KB1R w KQkq - 2 8' }

  describe '#self.fen_to_game_state' do
    context 'when converting a fen into a game_state' do
      it 'matches the equivalent game_state' do
        row_a = [' ', ' ', 'K', 'R', ' ', ' ', ' ', ' ']
        row_b = ['P', 'P', 'P', ' ', 'B', 'P', 'P', ' ']
        row_c = [' ', ' ', 'N', ' ', ' ', ' ', ' ', ' ']
        row_d = [' ', ' ', ' ', ' ', ' ', 'Q', ' ', ' ']
        row_e = [' ', ' ', ' ', 'p', ' ', ' ', ' ', ' ']
        row_f = ['p', 'q', 'p', ' ', ' ', 'p', ' ', 'P']
        row_g = [' ', ' ', ' ', ' ', ' ', ' ', 'R', 'p']
        row_h = [' ', 'r', 'b', ' ', 'r', ' ', 'n', 'k']
        board = [row_a, row_b, row_c, row_d, row_e, row_f, row_g, row_h]
        game_state = {
          piece_placement: board,
          side_to_move: 'b',
          castling_ability: '-',
          en_passant_target: '-',
          halfmove_clock: '0',
          fullmove_clock: '21'
        }
        result = Fen.fen_to_game_state(fen_string_a)
        expect(result).to eql(game_state)
      end

      it 'matches the equivalent game_state' do
        row_a = ['R', ' ', ' ', ' ', 'K', 'B', ' ', 'R']
        row_b = ['P', 'P', 'P', 'Q', ' ', 'P', 'P', 'P']
        row_c = [' ', ' ', 'N', ' ', ' ', ' ', ' ', ' ']
        row_d = [' ', ' ', ' ', 'N', 'P', ' ', ' ', ' ']
        row_e = [' ', ' ', ' ', ' ', ' ', ' ', 'B', ' ']
        row_f = [' ', ' ', 'n', 'p', 'p', 'n', ' ', ' ']
        row_g = ['p', 'p', ' ', ' ', 'b', 'p', 'p', 'p']
        row_h = ['r', ' ', 'b', 'q', 'k', ' ', ' ', 'r']
        board = [row_a, row_b, row_c, row_d, row_e, row_f, row_g, row_h]
        game_state = {
          piece_placement: board,
          side_to_move: 'w',
          castling_ability: 'KQkq',
          en_passant_target: '-',
          halfmove_clock: '2',
          fullmove_clock: '8'
        }
        result = Fen.fen_to_game_state(fen_string_b)
        expect(result).to eql(game_state)
      end
    end
  end

  describe '#self.game_state_to_fen' do
    context 'when converting a game_state to a fen' do
      it 'matches the equivalent fen_string' do
        row_a = [' ', ' ', 'K', 'R', ' ', ' ', ' ', ' ']
        row_b = ['P', 'P', 'P', ' ', 'B', 'P', 'P', ' ']
        row_c = [' ', ' ', 'N', ' ', ' ', ' ', ' ', ' ']
        row_d = [' ', ' ', ' ', ' ', ' ', 'Q', ' ', ' ']
        row_e = [' ', ' ', ' ', 'p', ' ', ' ', ' ', ' ']
        row_f = ['p', 'q', 'p', ' ', ' ', 'p', ' ', 'P']
        row_g = [' ', ' ', ' ', ' ', ' ', ' ', 'R', 'p']
        row_h = [' ', 'r', 'b', ' ', 'r', ' ', 'n', 'k']
        board = [row_a, row_b, row_c, row_d, row_e, row_f, row_g, row_h]
        game_state = {
          piece_placement: board,
          side_to_move: 'b',
          castling_ability: '-',
          en_passant_target: '-',
          halfmove_clock: '0',
          fullmove_clock: '21'
          }
        result = Fen.game_state_to_fen(game_state)
        expect(result).to eq(fen_string_a)
      end

      it 'matches the equivalent fen_string' do
        row_a = ['R', ' ', ' ', ' ', 'K', 'B', ' ', 'R']
        row_b = ['P', 'P', 'P', 'Q', ' ', 'P', 'P', 'P']
        row_c = [' ', ' ', 'N', ' ', ' ', ' ', ' ', ' ']
        row_d = [' ', ' ', ' ', 'N', 'P', ' ', ' ', ' ']
        row_e = [' ', ' ', ' ', ' ', ' ', ' ', 'B', ' ']
        row_f = [' ', ' ', 'n', 'p', 'p', 'n', ' ', ' ']
        row_g = ['p', 'p', ' ', ' ', 'b', 'p', 'p', 'p']
        row_h = ['r', ' ', 'b', 'q', 'k', ' ', ' ', 'r']
        board = [row_a, row_b, row_c, row_d, row_e, row_f, row_g, row_h]
        game_state = {
          piece_placement: board,
          side_to_move: 'w',
          castling_ability: 'KQkq',
          en_passant_target: '-',
          halfmove_clock: '2',
          fullmove_clock: '8'
        }
        result = Fen.game_state_to_fen(game_state)
        expect(result).to eql(fen_string_b)
      end
    end
  end

  describe '#self.fen_board_to_chess_board' do
    context 'when converting a fen_board to a chess_board' do
      matcher :equivalent_to_fen do |fen_board_flat|
        match do |chess_board_flat|
          index = 0
          chess_board_flat.all? do |chess_tile|
            fen_tile = fen_board_flat[index]
            index += 1
            if fen_tile == ' '
              chess_tile == fen_tile
            else
              color = fen_tile.match?(/[A-Z]/) ? 'light' : 'dark'
              map = { 'k' => King, 'q' => Queen, 'r' => Rook, 'b' => Bishop, 'n' => Knight, 'p' => Pawn }
              tile_class = map[fen_tile.downcase]
              (chess_tile.color == color) && chess_tile.instance_of?(tile_class)
            end
          end
        end
      end

      it 'returns an array replacing the fen letters into pieces' do
        fen_board = Fen.fen_to_game_state(fen_string_a)[:piece_placement]
        chessboard_flat = Fen.fen_board_to_chess_board(fen_board).flatten
        expect(chessboard_flat).to equivalent_to_fen(fen_board.flatten)
      end

      it 'returns an array replacing the fen letters into pieces' do
        fen_board = Fen.fen_to_game_state(fen_string_b)[:piece_placement]
        chessboard_flat = Fen.fen_board_to_chess_board(fen_board).flatten
        expect(chessboard_flat).to equivalent_to_fen(fen_board.flatten)
      end
    end
  end
end
