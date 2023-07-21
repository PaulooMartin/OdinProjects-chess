module MovementNonJump
  def all_moves_horizontal(row, column, max_moves_per_side)
    all_moves_left(row, column, max_moves_per_side) + all_moves_right(row, column, max_moves_per_side)
  end

  def all_moves_vertical(row, column, max_moves_per_side)
    all_moves_up(row, column, max_moves_per_side) + all_moves_down(row, column, max_moves_per_side)
  end

  def all_moves_diagonals(row, column, max_moves_per_side)
    diagonal_a = all_moves_upper_left(row, column,
                                      max_moves_per_side) + all_moves_lower_right(row, column, max_moves_per_side)
    diagonal_b = all_moves_lower_left(row, column,
                                      max_moves_per_side) + all_moves_upper_right(row, column, max_moves_per_side)
    diagonal_a + diagonal_b
  end

  def all_moves_left(coord_x, coord_y, max_moves)
    possible_coordinates = []
    current = coord_y
    max_moves.times do
      current -= 1
      possible_coordinates << [coord_x, current]
    end
    possible_coordinates.filter { |coords| coords[1].between?(0, 7) }
  end

  def all_moves_right(coord_x, coord_y, max_moves)
    possible_coordinates = []
    current = coord_y
    max_moves.times do
      current += 1
      possible_coordinates << [coord_x, current]
    end
    possible_coordinates.filter { |coords| coords[1].between?(0, 7) }
  end

  def all_moves_up(coord_x, coord_y, max_moves)
    possible_coordinates = []
    current = coord_x
    max_moves.times do
      current += 1
      possible_coordinates << [current, coord_y]
    end
    possible_coordinates.filter { |coords| coords[0].between?(0, 7) }
  end

  def all_moves_down(coord_x, coord_y, max_moves)
    possible_coordinates = []
    current = coord_x
    max_moves.times do
      current -= 1
      possible_coordinates << [current, coord_y]
    end
    possible_coordinates.filter { |coords| coords[0].between?(0, 7) }
  end

  def all_moves_upper_right(coord_x, coord_y, max_moves)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_moves.times do
      coords.map! { |coord| coord + 1 }
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(0, 7) && coords_y.between?(0, 7) }
  end

  def all_moves_upper_left(coord_x, coord_y, max_moves)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_moves.times do
      coords[0] += 1
      coords[1] -= 1
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(0, 7) && coords_y.between?(0, 7) }
  end

  def all_moves_lower_left(coord_x, coord_y, max_moves)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_moves.times do
      coords.map! { |coord| coord - 1 }
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(0, 7) && coords_y.between?(0, 7) }
  end

  def all_moves_lower_right(coord_x, coord_y, max_moves)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_moves.times do
      coords[0] -= 1
      coords[1] += 1
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(0, 7) && coords_y.between?(0, 7) }
  end
end