module MovementStraight
  def self.left(coord_x, coord_y, max_distance)
    possible_coordinates = []
    current = coord_y
    max_distance.times do
      current -= 1
      possible_coordinates << [coord_x, current]
    end
    possible_coordinates.filter { |coords| coords[1].between?(0, 7) }
  end

  def self.right(coord_x, coord_y, max_distance)
    possible_coordinates = []
    current = coord_y
    max_distance.times do
      current += 1
      possible_coordinates << [coord_x, current]
    end
    possible_coordinates.filter { |coords| coords[1].between?(0, 7) }
  end

  def self.up(coord_x, coord_y, max_distance)
    possible_coordinates = []
    current = coord_x
    max_distance.times do
      current += 1
      possible_coordinates << [current, coord_y]
    end
    possible_coordinates.filter { |coords| coords[0].between?(0, 7) }
  end

  def self.down(coord_x, coord_y, max_distance)
    possible_coordinates = []
    current = coord_x
    max_distance.times do
      current -= 1
      possible_coordinates << [current, coord_y]
    end
    possible_coordinates.filter { |coords| coords[0].between?(0, 7) }
  end

  def self.upright(coord_x, coord_y, max_distance)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_distance.times do
      coords.map! { |coord| coord + 1 }
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(0, 7) && coords_y.between?(0, 7) }
  end

  def self.upleft(coord_x, coord_y, max_distance)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_distance.times do
      coords[0] += 1
      coords[1] -= 1
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(0, 7) && coords_y.between?(0, 7) }
  end

  def self.lowright(coord_x, coord_y, max_distance)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_distance.times do
      coords[0] -= 1
      coords[1] += 1
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(0, 7) && coords_y.between?(0, 7) }
  end

  def self.lowleft(coord_x, coord_y, max_distance)
    possible_coordinates = []
    coords = [coord_x, coord_y]
    max_distance.times do
      coords.map! { |coord| coord - 1 }
      possible_coordinates << [coords[0], coords[1]]
    end
    possible_coordinates.filter { |coords_x, coords_y| coords_x.between?(0, 7) && coords_y.between?(0, 7) }
  end
end