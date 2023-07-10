require_relative 'player'

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

  def add_player_pieces_to_board
    add_player_light_pieces_to_board
    add_player_dark_pieces_to_board
  end

  def add_player_light_pieces_to_board
    @player_light.active_pieces.each do |piece|
      column, row = piece.current_coordinates
      @board[row][column] = piece
    end
  end

  def add_player_dark_pieces_to_board
    @player_dark.active_pieces.each do |piece|
      column, row = piece.current_coordinates
      @board[row][column] = piece
    end
  end
end
