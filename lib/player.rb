class Player
  attr_reader :name, :color
  attr_accessor :active_pieces

  def initialize(name, color)
    @name = name
    @color = color
    @active_pieces = nil
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