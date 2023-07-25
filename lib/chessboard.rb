require_relative 'player'
require_relative 'chess_pieces'

class Chessboard
  def initialize
    @board = Array.new(8) { Array.new(8, ' ') }
    @player_light = Player.new('placeholder', 'light')
    @player_dark = Player.new('placeholder', 'dark')
    @current_player = @player_light
    add_player_pieces_to_board
  end

  def print_chessboard
    dark = 'd3d3d3'
    light = 'white'
    @board.reverse.each_with_index do |row, row_num|
      bg_color = row_num.even? ? light : dark
      print " #{8 - row_num} "
      row.each do |piece|
        tile = " #{piece.is_a?(String) ? ' ' : piece.symbol} "
        print Paint[tile, 'black', bg_color]
        bg_color = switch_bg_color(bg_color)
      end
      puts ''
    end
    puts '    a  b  c  d  e  f  g  h '
  end

  private

  def switch_bg_color(current)
    dark = 'd3d3d3'
    light = 'white'
    current == dark ? light : dark
  end

  def switch_current_player
    @current_player = @current_player == @player_light ? @player_dark : @player_light
  end

  def enemy_player
    @current_player.equal?(@player_light) ? @player_dark : @player_light
  end

  def add_player_pieces_to_board
    add_player_light_pieces_to_board
    add_player_dark_pieces_to_board
  end

  def add_player_light_pieces_to_board
    @player_light.active_pieces.values.flatten.each do |piece|
      row, column = piece.current_coordinates
      @board[row][column] = piece
    end
  end

  def add_player_dark_pieces_to_board
    @player_dark.active_pieces.values.flatten.each do |piece|
      row, column = piece.current_coordinates
      @board[row][column] = piece
    end
  end

  def transform_player_input_to_origin_destination(player_input)
    origin_to_destination = player_input.scan(/[a-h][1-8]/)
    origin_to_destination.map! { |algebraic| transform_algebraic_to_board_coordinates(algebraic) }
  end

  def transform_algebraic_to_board_coordinates(algebraic_string)
    column = algebraic_string[0].ord - 'a'.ord
    row = algebraic_string[1].to_i - 1
    [row, column]
  end

  def determine_path_end(unfiltered_path, jump = false)
    filtered_path = []
    unfiltered_path.each do |row, column|
      tile_occupant = @board[row][column]
      filtered_path << [row, column]
      if tile_occupant.is_a?(ChessPiece)
        filtered_path.pop if tile_occupant.owner == @current_player
        break unless jump
      end
    end
    filtered_path
  end
end