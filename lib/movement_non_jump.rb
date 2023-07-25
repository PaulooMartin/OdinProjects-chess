module MovementNonJump
  def make_straight_path_left(coord_x, coord_y, max_moves)
    possible_coordinates = []
    current = coord_y
    max_moves.times do
      current -= 1
      possible_coordinates << [coord_x, current]
    end
    possible_coordinates.filter { |coords| coords[1].between?(0, 7) }
  end

  def make_straight_path_right(coord_x, coord_y, max_moves)
    possible_coordinates = []
    current = coord_y
    max_moves.times do
      current += 1
      possible_coordinates << [coord_x, current]
    end
    possible_coordinates.filter { |coords| coords[1].between?(0, 7) }
  end

  def make_straight_path_up(coord_x, coord_y, max_moves)
    possible_coordinates = []
    current = coord_x
    max_moves.times do
      current += 1
      possible_coordinates << [current, coord_y]
    end
    possible_coordinates.filter { |coords| coords[0].between?(0, 7) }
  end

  def make_straight_path_down(coord_x, coord_y, max_moves)
    possible_coordinates = []
    current = coord_x
    max_moves.times do
      current -= 1
      possible_coordinates << [current, coord_y]
    end
    possible_coordinates.filter { |coords| coords[0].between?(0, 7) }
  end

  def make_straight_path_upright(coord_x, coord_y, max_moves)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_moves.times do
      coords.map! { |coord| coord + 1 }
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(0, 7) && coords_y.between?(0, 7) }
  end

  def make_straight_path_upleft(coord_x, coord_y, max_moves)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_moves.times do
      coords[0] += 1
      coords[1] -= 1
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(0, 7) && coords_y.between?(0, 7) }
  end

  def make_straight_path_lowleft(coord_x, coord_y, max_moves)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_moves.times do
      coords.map! { |coord| coord - 1 }
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(0, 7) && coords_y.between?(0, 7) }
  end

  def make_straight_path_lowright(coord_x, coord_y, max_moves)
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