class Chessboard
  def play
    # initialize_game
    # until game_end?
    #   player_move = nil
    #   prompt_counter = -1

    #   until valid_move?()
    #     prompt_counter += 1
    #     puts invalid move message
    #     player_input = prompt_player (extend the input choices)
    #     action_from_player_input (move, save_game, resign, show_fen)
    #   end

    #   moving the stuff
    #   changing the current_player
    # end
  end

  def print_chessboard(board = @board)
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

  private

  def switch_bg_color(current)
    dark = 'd3d3d3'
    light = 'white'
    current == dark ? light : dark
  end

  # all the instance variables needed will be initialized here
  def initialize_game
    # prompt for starting fen
    # players and add prompt name inside Player class
    # starting_game_state from fen
    # board from start_state
    # current_player from start_state
    # things from start_state
  end

  # checkmate, stalemate, resign, Rule::50-move-rule
  def game_end?; end
  def all_light_pieces; end
  def all_dark_pieces; end
end
