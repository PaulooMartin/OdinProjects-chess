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

  def determine_path_end(unfiltered_path, origin_color, knight = false)
    filtered_path = []
    unfiltered_path.each do |row, column|
      tile_occupant = @board[row][column]
      filtered_path << [row, column]
      if tile_occupant.is_a?(ChessPiece)
        filtered_path.pop if tile_occupant.color == origin_color
        break unless knight
      end
    end
    filtered_path
  end

  def king_in_check?(color, board = @board)
    king = find_king_in_board(color, board)
    attacker_paths_map = get_king_attacker_paths(king)
    attacker_paths = attacker_paths_map.values.flatten(1)
    possible_attackers = get_all_pieces_in_all_paths(attacker_paths, board)
    possible_attackers.any? { |enemy_piece| enemy_piece.can_attack?(king) }
  end

  def get_king_attacker_paths(king)
    attacker_paths_map = king.attacker_all_paths
    attacker_paths_map.each_key do |path_name|
      attacker_paths_map[path_name].map! do |path|
        is_knight = path_name.eql?(:knight)
        determine_path_end(path, king.color, is_knight)
      end
    end
    attacker_paths_map
  end

  def get_all_pieces_in_all_paths(attackers_paths, board)
    all_occupants_inside_paths = attackers_paths.map do |path|
      path.map { |row, column| board[row][column] }
    end
    all_occupants = all_occupants_inside_paths.flatten
    all_occupants.filter { |occupant| occupant.is_a?(ChessPiece) }
  end

  def find_king_in_board(color, board = @board)
    board.flatten.find do |tile_occupant|
      tile_occupant.is_a?(King) && tile_occupant.color == color
    end
  end
end
