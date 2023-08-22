require 'paint'
require_relative 'player'
require_relative 'chessboard'
require_relative 'chess_pieces'
require_relative 'fen'
require_relative 'validmove'
require_relative 'check'
require_relative 'movement_jump'
require_relative 'movement_straight'
require_relative 'move_path_stop'

def valid_move?(board, side_to_move, player_move)
  return false unless player_move

  row_orig, col_orig = player_move[0]
  destination = player_move[1]

  piece_to_move = board[row_orig][col_orig]
  destination_tile = board[destination[0]][destination[1]]
  ValidMove.a_chesspiece?(piece_to_move) &&
    ValidMove.not_a_king?(destination_tile) &&
    ValidMove.matching_colors?(side_to_move, piece_to_move) &&
    ValidMove.within_piece_path?(board, piece_to_move, destination) &&
    !ValidMove.move_results_in_check?(board, piece_to_move, destination)
end

def print_chessboard(board)
  dark = 'd3d3d3'
  light = 'white'
  board.reverse.each_with_index do |row, row_num|
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

def switch_bg_color(current)
  dark = 'd3d3d3'
  light = 'white'
  current == dark ? light : dark
end

start_fen = 'k7/8/K7/8/8/8/8/7Q w - - 0 1'
player_light = Player.new('layt', 'light')
player_dark = Player.new('darc', 'dark')

current_game_state = Fen.fen_to_game_state(start_fen)
chessboard = Fen.fen_board_to_chess_board(current_game_state[:piece_placement])
castling_ability = current_game_state[:castling_ability]
en_passant_target = current_game_state[:en_passant_target]
halfmove_clock = current_game_state[:halfmove_clock]
fullmove_clock = current_game_state[:fullmove_clock]
if current_game_state[:side_to_move] == 'w'
  side_to_move = player_light
elsif current_game_state [:side_to_move] == 'b'
  side_to_move = player_dark
end

game_end = false
print_chessboard(chessboard)
until game_end
  player_move = nil
  prompt_counter = -1

  until valid_move?(chessboard, side_to_move, player_move)
    prompt_counter += 1
    puts 'You gave an invalid move. Please give a valid move :)' if prompt_counter.positive?
    player_input = side_to_move.prompt_player
    player_move = Player.transform_player_input_to_origin_destination(player_input)
  end

  row_orig, col_orig = player_move[0]
  row_dest, col_dest = player_move[1]
  piece_to_move = chessboard[row_orig][col_orig]

  piece_to_move.current_coordinates = [row_dest, col_dest]
  chessboard[row_orig][col_orig] = ' '
  chessboard[row_dest][col_dest] = piece_to_move
  print_chessboard(chessboard)

  side_to_move = side_to_move == player_light ? player_dark : player_light
end
