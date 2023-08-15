require 'movement_straight'

# rubocop:disable Metrics/BlockLength
describe 'MovementStraight' do
  describe '#self.left' do
    context 'when making left straight movements at the edges of the board' do
      it 'returns the correct possible moves' do
        coord_x = 0
        coord_y = 7
        max_distance = 7
        expected_result = [[0, 6], [0, 5], [0, 4], [0, 3], [0, 2], [0, 1], [0, 0]]
        result = MovementStraight.left(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 0
        coord_y = 0
        max_distance = 7
        expected_result = []
        result = MovementStraight.left(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end

    context 'when making left straight moves at random coords' do
      it 'returns the correct possible moves' do
        coord_x = 4
        coord_y = 4
        max_distance = 7
        expected_result = [[4, 3], [4, 2], [4, 1], [4, 0]]
        result = MovementStraight.left(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 1
        coord_y = 5
        max_distance = 7
        expected_result = [[1, 4], [1, 3], [1, 2], [1, 1], [1, 0]]
        result = MovementStraight.left(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 6
        coord_y = 6
        max_distance = 7
        expected_result = [[6, 5], [6, 4], [6, 3], [6, 2], [6, 1], [6, 0]]
        result = MovementStraight.left(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end
  end

  describe '#self.right' do
    context 'when making right straight movements at the edges of the board' do
      it 'returns the correct possible moves' do
        coord_x = 0
        coord_y = 7
        max_distance = 7
        expected_result = []
        result = MovementStraight.right(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 0
        coord_y = 0
        max_distance = 7
        expected_result = [[0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]]
        result = MovementStraight.right(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end

    context 'when making right straight moves at random coords' do
      it 'returns the correct possible moves' do
        coord_x = 4
        coord_y = 4
        max_distance = 7
        expected_result = [[4, 5], [4, 6], [4, 7]]
        result = MovementStraight.right(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 1
        coord_y = 5
        max_distance = 7
        expected_result = [[1, 6], [1, 7]]
        result = MovementStraight.right(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 6
        coord_y = 6
        max_distance = 7
        expected_result = [[6, 7]]
        result = MovementStraight.right(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end
  end

  describe '#self.up' do
    context 'when making up straight movements at the edges of the board' do
      it 'returns the correct possible moves' do
        coord_x = 0
        coord_y = 0
        max_distance = 7
        expected_result = [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0]]
        result = MovementStraight.up(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 7
        coord_y = 7
        max_distance = 7
        expected_result = []
        result = MovementStraight.up(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end

    context 'when making up straight movements at random coords' do
      it 'returns the correct possible moves' do
        coord_x = 4
        coord_y = 4
        max_distance = 7
        expected_result = [[5, 4], [6, 4], [7, 4]]
        result = MovementStraight.up(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 6
        coord_y = 1
        max_distance = 7
        expected_result = [[7, 1]]
        result = MovementStraight.up(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 2
        coord_y = 3
        max_distance = 7
        expected_result = [[3, 3], [4, 3], [5, 3], [6, 3], [7, 3]]
        result = MovementStraight.up(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end
  end

  describe '#self.down' do
    context 'when making down straight movements at the edges of the board' do
      it 'returns the correct possible moves' do
        coord_x = 0
        coord_y = 0
        max_distance = 7
        expected_result = []
        result = MovementStraight.down(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 7
        coord_y = 7
        max_distance = 7
        expected_result = [[6, 7], [5, 7], [4, 7], [3, 7], [2, 7], [1, 7], [0, 7]]
        result = MovementStraight.down(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end

    context 'when making up straight movements at random coords' do
      it 'returns the correct possible moves' do
        coord_x = 4
        coord_y = 4
        max_distance = 7
        expected_result = [[3, 4], [2, 4], [1, 4], [0, 4]]
        result = MovementStraight.down(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 6
        coord_y = 1
        max_distance = 7
        expected_result = [[5, 1], [4, 1], [3, 1], [2, 1], [1, 1], [0, 1]]
        result = MovementStraight.down(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 2
        coord_y = 3
        max_distance = 7
        expected_result = [[1, 3], [0, 3]]
        result = MovementStraight.down(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end
  end

  describe '#self.upright' do
    context 'when making upright straight movements at edges of the board' do
      it 'returns the correct possible moves' do
        coord_x = 0
        coord_y = 0
        max_distance = 7
        expected_result = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7]]
        result = MovementStraight.upright(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 7
        coord_y = 7
        max_distance = 7
        expected_result = []
        result = MovementStraight.upright(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end

    context 'when making upright straight movements at random coords' do
      it 'returns the correct possible moves' do
        coord_x = 4
        coord_y = 4
        max_distance = 7
        expected_result = [[5, 5], [6, 6], [7, 7]]
        result = MovementStraight.upright(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 1
        coord_y = 7
        max_distance = 7
        expected_result = []
        result = MovementStraight.upright(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 1
        coord_y = 3
        max_distance = 7
        expected_result = [[2, 4], [3, 5], [4, 6], [5, 7]]
        result = MovementStraight.upright(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end
  end

  describe '#self.upleft' do
    context 'when making upleft straight movements at edges of the board' do
      it 'returns the correct possible moves' do
        coord_x = 7
        coord_y = 0
        max_distance = 7
        expected_result = []
        result = MovementStraight.upleft(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 0
        coord_y = 7
        max_distance = 7
        expected_result = [[1, 6], [2, 5], [3, 4], [4, 3], [5, 2], [6, 1], [7, 0]]
        result = MovementStraight.upleft(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end

    context 'when making upleft straight movements at random coords' do
      it 'returns the correct possible moves' do
        coord_x = 4
        coord_y = 4
        max_distance = 7
        expected_result = [[5, 3], [6, 2], [7, 1]]
        result = MovementStraight.upleft(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 1
        coord_y = 7
        max_distance = 7
        expected_result = [[2, 6], [3, 5], [4, 4], [5, 3], [6, 2], [7, 1]]
        result = MovementStraight.upleft(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 1
        coord_y = 3
        max_distance = 7
        expected_result = [[2, 2], [3, 1], [4, 0]]
        result = MovementStraight.upleft(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end
  end

  describe '#self.lowright' do
    context 'when making lowright straight movements at edges of the board' do
      it 'returns the correct possible moves' do
        coord_x = 7
        coord_y = 0
        max_distance = 7
        expected_result = [[6, 1], [5, 2], [4, 3], [3, 4], [2, 5], [1, 6], [0, 7]]
        result = MovementStraight.lowright(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 0
        coord_y = 7
        max_distance = 7
        expected_result = []
        result = MovementStraight.lowright(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end

    context 'when making lowright straight movements at random coords' do
      it 'returns the correct possible moves' do
        coord_x = 4
        coord_y = 4
        max_distance = 7
        expected_result = [[3, 5], [2, 6], [1, 7]]
        result = MovementStraight.lowright(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 1
        coord_y = 7
        max_distance = 7
        expected_result = []
        result = MovementStraight.lowright(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 1
        coord_y = 3
        max_distance = 7
        expected_result = [[0, 4]]
        result = MovementStraight.lowright(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end
  end

  describe '#self.lowleft' do
    context 'when making lowleft straight movements at edges of the board' do
      it 'returns the correct possible moves' do
        coord_x = 0
        coord_y = 0
        max_distance = 7
        expected_result = []
        result = MovementStraight.lowleft(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 7
        coord_y = 7
        max_distance = 7
        expected_result = [[6, 6], [5, 5], [4, 4], [3, 3], [2, 2], [1, 1], [0, 0]]
        result = MovementStraight.lowleft(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end

    context 'when making lowleft straight movements at random coords' do
      it 'returns the correct possible moves' do
        coord_x = 4
        coord_y = 4
        max_distance = 7
        expected_result = [[3, 3], [2, 2], [1, 1], [0, 0]]
        result = MovementStraight.lowleft(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 1
        coord_y = 7
        max_distance = 7
        expected_result = [[0, 6]]
        result = MovementStraight.lowleft(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end

      it 'returns the correct possible moves' do
        coord_x = 1
        coord_y = 3
        max_distance = 7
        expected_result = [[0, 2]]
        result = MovementStraight.lowleft(coord_x, coord_y, max_distance)
        expect(result).to eql(expected_result)
      end
    end
  end
end
