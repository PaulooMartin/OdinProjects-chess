class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def self.transform_player_input_to_origin_destination(player_input)
    origin_to_destination = player_input.scan(/[a-h][1-8]/)
    origin_to_destination.map! do |algebraic|
      column = algebraic[0].ord - 'a'.ord
      row = algebraic[1].to_i - 1
      [row, column]
    end
  end

  def prompt_player
    player_input = ''
    until player_input.match?(/\A[a-h][1-8][a-h][1-8]\z/)
      print "#{@name}'s turn. Give your coordinates: "
      player_input = gets.chomp.downcase
    end
    player_input
  end
end