class Player
  attr_reader :name, :color
  attr_accessor :active_pieces

  def initialize(name, color)
    @name = name
    @color = color
    @active_pieces = init_create_pieces
  end

  def prompt_player
    player_input = ''
    until player_input_valid?(player_input)
      print "#{@name}'s turn. Give your coordinates: "
      player_input = gets.chomp.downcase
    end
    player_input
  end

  private

  def player_input_valid?(player_input)
    matcher = /\A[a-h][1-8][a-h][1-8]\z/
    player_input.match?(matcher)
  end

  def init_create_pieces
    officials_row = @color == 'light' ? 0 : 7
    pawns_row = @color == 'light' ? 1 : 6
    init_create_pawns(pawns_row) + init_create_officials(officials_row)
  end

  def init_create_pawns(pawns_row)
    total_pawns = 8
    pawns = []
    total_pawns.times do |column|
      pawns << Pawn.new(@color, [pawns_row, column])
    end
    pawns
  end

  def init_create_officials(officials_row)
    rooks = init_create_rooks(officials_row)
    horses = init_create_horses(officials_row)
    bishops = init_create_bishops(officials_row)
    queen = init_create_queen(officials_row)
    king = init_create_king(officials_row)
    rooks + horses + bishops + queen + king
  end

  def init_create_rooks(officials_row)
    rook_a_coordinates = [officials_row, 0]
    rook_b_coordinates = [officials_row, 7]
    [Rook.new(@color, rook_a_coordinates), Rook.new(@color, rook_b_coordinates)]
  end

  def init_create_horses(officials_row)
    horse_a_coordinates = [officials_row, 1]
    horse_b_coordinates = [officials_row, 6]
    [Horse.new(@color, horse_a_coordinates), Horse.new(@color, horse_b_coordinates)]
  end

  def init_create_bishops(officials_row)
    bishop_a_coordinates = [officials_row, 2]
    bishop_b_coordinates = [officials_row, 5]
    [Bishop.new(@color, bishop_a_coordinates), Bishop.new(@color, bishop_b_coordinates)]
  end

  def init_create_king(officials_row)
    king_coordinates = [officials_row, 4]
    [King.new(@color, king_coordinates)]
  end

  def init_create_queen(officials_row)
    queen_coordinates = [officials_row, 3]
    [Queen.new(@color, queen_coordinates)]
  end
end