module MovementJump
  def generate_possible_moves_horizontal(coord_x, coord_y)
    possible_coordinates = []
    [-2, 2].each do |shift_x|
      [-1, 1].each do |shift_y|
        possible_coordinates << [coord_x + shift_x, coord_y + shift_y]
      end
    end
    possible_coordinates.keep_if { |x, y| x.between?(1, 8) && y.between?(1, 8) }
  end

  def generate_possible_moves_vertical(coord_x, coord_y)
    possible_coordinates = []
    [-1, 1].each do |shift_x|
      [-2, 2].each do |shift_y|
        possible_coordinates << [coord_x + shift_x, coord_y + shift_y]
      end
    end
    possible_coordinates.keep_if { |x, y| x.between?(1, 8) && y.between?(1, 8) }
  end
end
