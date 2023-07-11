class Player
  attr_reader :name, :color
  attr_accessor :active_pieces

  def initialize(name, color)
    @name = name
    @color = color
    @active_pieces = init_create_pieces
  end

  def prompt_player
    validity = false
    until validity
      print "#{@name}'s turn. Give your coordinates: "
      player_input = gets.chomp.downcase
      validity = validate_player_input(player_input)
    end
    player_input
  end

  private

  def validate_player_input(player_input)
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
      pawns << Pawn.new(@color, [column, pawns_row])
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
    rook_a_coordinates = [0, officials_row]
    rook_b_coordinates = [7, officials_row]
    [Rook.new(@color, rook_a_coordinates), Rook.new(@color, rook_b_coordinates)]
  end

  def init_create_horses(officials_row)
    horse_a_coordinates = [1, officials_row]
    horse_b_coordinates = [6, officials_row]
    [Horse.new(@color, horse_a_coordinates), Horse.new(@color, horse_b_coordinates)]
  end

  def init_create_bishops(officials_row)
    bishop_a_coordinates = [2, officials_row]
    bishop_b_coordinates = [5, officials_row]
    [Bishop.new(@color, bishop_a_coordinates), Bishop.new(@color, bishop_b_coordinates)]
  end

  def init_create_king(officials_row)
    king_coordinates = [4, officials_row]
    [King.new(@color, king_coordinates)]
  end

  def init_create_queen(officials_row)
    queen_coordinates = [3, officials_row]
    [Queen.new(@color, queen_coordinates)]
  end
end