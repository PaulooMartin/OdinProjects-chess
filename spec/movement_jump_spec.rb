require 'movement_jump'

# rubocop:disable Metrics/BlockLength
describe 'MovementJump' do


  describe '#self.horizontal' do
    context 'when making horizontal jumps at the edges of board' do
      it 'returns the correct possible move' do
        row = 0
        column = 0
        expected_result = [[1, 2]]
        result = MovementJump.horizontal(row, column)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible move' do
        row = 7
        column = 7
        expected_result = [[6, 5]]
        result = MovementJump.horizontal(row, column)
        expect(result).to eql(expected_result)
      end
    end

    context 'when making horizontal jumps at random coords' do
      it 'returns the correct possible moves' do
        row = 4
        column = 4
        expected_result = [[3, 2], [3, 6], [5, 2], [5, 6]]
        result = MovementJump.horizontal(row, column)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        row = 2
        column = 7
        expected_result = [[1, 5], [3, 5]]
        result = MovementJump.horizontal(row, column)
        expect(result).to eql(expected_result)
      end
    end
  end

  describe '#self.vertical' do
    context 'when making vertical jumps at edges of board' do
      it 'returns the correct possible move' do
        row = 0
        column = 0
        expected_result = [[2, 1]]
        result = MovementJump.vertical(row, column)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible move' do
        row = 7
        column = 7
        expected_result = [[5, 6]]
        result = MovementJump.vertical(row, column)
        expect(result).to eql(expected_result)
      end
    end

    context 'when making vertical jumps at random coords' do
      it 'returns the correct possible moves' do
        row = 4
        column = 4
        expected_result = [[2, 3], [2, 5], [6, 3], [6, 5]]
        result = MovementJump.vertical(row, column)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        row = 3
        column = 3
        expected_result = [[1, 2], [1, 4], [5, 2], [5, 4]]
        result = MovementJump.vertical(row, column)
        expect(result).to eql(expected_result)
      end
    end
  end
end
