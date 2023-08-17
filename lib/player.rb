class Player
  attr_reader :name, :color
  attr_accessor :active_pieces

  def initialize(name, color)
    @name = name
    @color = color
  end

  def self.transform_player_input_to_origin_destination(player_input)
    origin_to_destination = player_input.scan(/[a-h][1-8]/)
    origin_to_destination.map! { |algebraic| transform_algebraic_to_board_coordinates(algebraic) }
  end

  def prompt_player
    player_input = ''
    until player_input.match?(/\A[a-h][1-8][a-h][1-8]\z/)
      print "#{@name}'s turn. Give your coordinates: "
      player_input = gets.chomp.downcase
    end
    player_input
  end

  private

  def transform_algebraic_to_board_coordinates(algebraic_string)
    column = algebraic_string[0].ord - 'a'.ord
    row = algebraic_string[1].to_i - 1
    [row, column]
  end
end