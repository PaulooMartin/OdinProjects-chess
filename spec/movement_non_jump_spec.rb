require 'movement_non_jump'

class PsuedoChessPiece
  include MovementNonJump
end

# rubocop:disable Metrics/BlockLength
describe 'Movement_non_jump' do
  subject(:dummy) { PsuedoChessPiece.new }
  describe '#all_moves_horizontal' do
    context 'when getting all horizontal moves at the very edges of board' do
      it 'returns all horizontal moves going left' do
        coord_x = 0
        coord_y = 7
        max_moves = 7
        expected_result = [[0, 6], [0, 5], [0, 4], [0, 3], [0, 2], [0, 1], [0, 0]]
        result = dummy.all_moves_horizontal(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end

      it 'returns all horizontal moves going right' do
        coord_x = 0
        coord_y = 0
        max_moves = 7
        expected_result = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]]
        result = dummy.all_moves_horizontal(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end
    end

    context 'when getting all horizontal moves at random coordinates' do
      it 'returns all the horizontal moves' do
        coord_x = 4
        coord_y = 4
        max_moves = 7
        expected_result = [[4, 3], [4, 2], [4, 1], [4, 0], [4, 5], [4, 6], [4, 7], ]
        result = dummy.all_moves_horizontal(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end

      it 'returns all the horizontal moves' do
        coord_x = 1
        coord_y = 5
        max_moves = 7
        expected_result = [[1, 4], [1, 3], [1, 2], [1, 1], [1, 0], [1, 6], [1, 7], ]
        result = dummy.all_moves_horizontal(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end

      it 'returns all the horizontal moves' do
        coord_x = 6
        coord_y = 6
        max_moves = 7
        expected_result = [[6, 5], [6, 4], [6, 3], [6, 2], [6, 1], [6, 0], [6, 7], ]
        result = dummy.all_moves_horizontal(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end
    end
  end

  describe '#all_moves_vertical' do
    context 'when getting all vertical moves at the very edges of board' do
      it 'returns all vertical moves going down' do
        coord_x = 7
        coord_y = 0
        max_moves = 7
        expected_result = [[6, 0], [5, 0], [4, 0], [3, 0], [2, 0], [1, 0], [0, 0]]
        result = dummy.all_moves_vertical(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end

      it 'returns all vertical moves going up' do
        coord_x = 0
        coord_y = 7
        max_moves = 7
        expected_result = [[1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7], [7, 7]]
        result = dummy.all_moves_vertical(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end
    end

    context 'when getting all vertical moves at random coords' do
      it 'returns all the vertical moves' do
        coord_x = 4
        coord_y = 4
        max_moves = 7
        expected_result = [[5, 4], [6, 4], [7, 4], [3, 4], [2, 4], [1, 4], [0, 4]]
        result = dummy.all_moves_vertical(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end

      it 'returns all the vertical moves' do
        coord_x = 6
        coord_y = 1
        max_moves = 7
        expected_result = [[7, 1], [5, 1], [4, 1], [3, 1], [2, 1], [1, 1], [0, 1]]
        result = dummy.all_moves_vertical(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end

      it 'returns all the vertical moves' do
        coord_x = 5
        coord_y = 5
        max_moves = 7
        expected_result = [[6, 5], [7, 5], [4, 5], [3, 5], [2, 5], [1, 5], [0, 5]]
        result = dummy.all_moves_vertical(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end
    end
  end

  describe '#all_moves_diagonals' do
    context 'when getting all diagonal moves at the very edges of board' do
      it 'returns all diagonal moves going up-right' do
        coord_x = 0
        coord_y = 0
        max_moves = 7
        expected_result = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        result = dummy.all_moves_diagonals(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end

      it 'returns all diagonal moves going up-left' do
        coord_x = 0
        coord_y = 7
        max_moves = 7
        expected_result = [[1, 6], [2, 5], [3, 4], [4, 3], [5, 2], [6, 1], [7, 0]]
        result = dummy.all_moves_diagonals(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end

      it 'returns all diagonal moves going down-right' do
        coord_x = 7
        coord_y = 0
        max_moves = 7
        expected_result = [[6, 1], [5, 2], [4, 3], [3, 4], [2, 5], [1, 6], [0, 7]]
        result = dummy.all_moves_diagonals(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end

      it 'returns all diagonal moves going down-left' do
        coord_x = 7
        coord_y = 7
        max_moves = 7
        expected_result = [[6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1], [0, 0]]
        result = dummy.all_moves_diagonals(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end
    end

    context 'when getting all diagonal moves at random coords' do
      it 'returns all diagonal moves' do
        coord_x = 4
        coord_y = 4
        max_moves = 7
        first_diagonal = [[5, 3], [6, 2], [7, 1], [3, 5], [2, 6], [1, 7]]
        second_diagonal = [[3, 3], [2, 2], [1, 1], [0, 0], [5, 5], [6, 6], [7, 7]]
        expected_result = first_diagonal + second_diagonal
        result = dummy.all_moves_diagonals(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end

      it 'returns all diagonal moves' do
        coord_x = 6
        coord_y = 2
        max_moves = 7
        first_diagonal = [[7, 1], [5, 3], [4, 4], [3, 5], [2, 6], [1, 7]]
        second_diagonal = [[5, 1], [4, 0], [7, 3]]
        expected_result = first_diagonal + second_diagonal
        result = dummy.all_moves_diagonals(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end

      it 'returns all diagonal moves' do
        coord_x = 1
        coord_y = 4
        max_moves = 7
        first_diagonal = [[2, 3], [3, 2], [4, 1], [5, 0], [0, 5]]
        second_diagonal = [[0, 3], [2, 5], [3, 6], [4, 7]]
        expected_result = first_diagonal + second_diagonal
        result = dummy.all_moves_diagonals(coord_x, coord_y, max_moves)
        expect(result).to eql(expected_result)
      end
    end
  end
end
