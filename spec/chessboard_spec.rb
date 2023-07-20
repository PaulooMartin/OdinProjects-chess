require 'chessboard'
require 'player'
require 'chess_pieces'

# rubocop:disable Metrics/BlockLength
describe Chessboard do
  subject(:chessboard) { described_class.new }
  describe '#add_player_pieces_to_board' do
    context "when adding players' pieces" do
      subject(:board) { chessboard.instance_variable_get(:@board) }
      subject(:player_light) { chessboard.instance_variable_get(:@player_light) }
      subject(:player_dark) { chessboard.instance_variable_get(:@player_dark) }

      it 'adds any chesspiece' do
        result = board.any? { |row| row.any? { |tile| tile.is_a?(ChessPiece) } }
        expect(result).to be(true)
      end

      it 'adds the light pieces to the correct row of the board' do
        row_a = board[0].all? { |tile| tile.owner == player_light }
        row_b = board[1].all? { |tile| tile.owner == player_light }
        result = row_a && row_b
        expect(result).to be(true)
      end

      it 'adds the dark pieces to the board' do
        row_a = board[7].all? { |tile| tile.owner == player_dark }
        row_b = board[6].all? { |tile| tile.owner == player_dark }
        result = row_a && row_b
        expect(result).to be(true)
      end
    end
  end

  describe '#transform_player_input_to_origin_destination' do
    context 'when transforming the player_input' do
      it 'returns an array' do
        player_input = 'a1f5'
        result = chessboard.transform_player_input_to_origin_destination(player_input)
        expect(result).to be_an(Array)
      end

      it 'has two elements' do
        player_input = 'a1f5'
        result = chessboard.transform_player_input_to_origin_destination(player_input).length
        expect(result).to eq(2)
      end

      it 'all elements are an Array' do
        player_input = 'a1f5'
        origin_destination = chessboard.transform_player_input_to_origin_destination(player_input)
        result = origin_destination.all? { |element| element.is_a?(Array) }
        expect(result).to be(true)
      end

      it 'all elements has two elements' do
        player_input = 'a1f8'
        origin_destination = chessboard.transform_player_input_to_origin_destination(player_input)
        result = origin_destination.all? { |coords| coords.length == 2 }
        expect(result).to be(true)
      end

      it 'all elements within all elements are numbers between 0 and 7' do
        player_input = 'a3f8'
        origin_destination = chessboard.transform_player_input_to_origin_destination(player_input)
        result = origin_destination.all? { |coords| coords.all? { |coord| coord.between?(0, 7) } }
        expect(result).to be(true)
      end
    end
  end
end
