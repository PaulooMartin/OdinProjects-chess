require 'movement_jump'

class PsuedoChessPiece
  include MovementJump
end

# rubocop:disable Metrics/BlockLength
describe 'Movement_jump' do
  subject(:dummy) { PsuedoChessPiece.new }

  describe '#generate_possible_moves_horizontal' do
    context 'when generating jump_moves at edges of board' do
      it 'returns the correct possible move' do
        row = 0
        column = 0
        expected_result = [[1, 2]]
        result = dummy.generate_possible_moves_horizontal(row, column)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible move' do
        row = 7
        column = 7
        expected_result = [[6, 5]]
        result = dummy.generate_possible_moves_horizontal(row, column)
        expect(result).to eql(expected_result)
      end
    end

    context 'when generating jump_moves at random coords' do
      it 'returns the correct possible moves' do
        row = 4
        column = 4
        expected_result = [[3, 2], [3, 6], [5, 2], [5, 6]]
        result = dummy.generate_possible_moves_horizontal(row, column)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        row = 2
        column = 7
        expected_result = [[1, 5], [3, 5]]
        result = dummy.generate_possible_moves_horizontal(row, column)
        expect(result).to eql(expected_result)
      end
    end
  end

  describe '#generate_possible_moves_vertical' do
    context 'when generating jump moves at edges of board' do
      it 'returns the correct possible move' do
        row = 0
        column = 0
        expected_result = [[2, 1]]
        result = dummy.generate_possible_moves_vertical(row, column)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible move' do
        row = 7
        column = 7
        expected_result = [[5, 6]]
        result = dummy.generate_possible_moves_vertical(row, column)
        expect(result).to eql(expected_result)
      end
    end

    context 'when generating jump_moves at random coords' do
      it 'returns the correct possible moves' do
        row = 4
        column = 4
        expected_result = [[2, 3], [2, 5], [6, 3], [6, 5]]
        result = dummy.generate_possible_moves_vertical(row, column)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        row = 3
        column = 3
        expected_result = [[1, 2], [1, 4], [5, 2], [5, 4]]
        result = dummy.generate_possible_moves_vertical(row, column)
        expect(result).to eql(expected_result)
      end
    end
  end
end
