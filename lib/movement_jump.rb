module MovementJump
  def generate_possible_moves_horizontal(row, column)
    possible_coordinates = []
    [-1, 1].each do |shift_x|
      [-2, 2].each do |shift_y|
        possible_coordinates << [row + shift_x, column + shift_y]
      end
    end
    possible_coordinates.keep_if { |x, y| x.between?(0, 7) && y.between?(0, 7) }
  end

  def generate_possible_moves_vertical(row, column)
    possible_coordinates = []
    [-2, 2].each do |shift_x|
      [-1, 1].each do |shift_y|
        possible_coordinates << [row + shift_x, column + shift_y]
      end
    end
    possible_coordinates.keep_if { |x, y| x.between?(0, 7) && y.between?(0, 7) }
  end
end
