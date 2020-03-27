require 'colorize'
require_relative '../board_components/board'
# require_relative 'cursor'

class Display
  def initialize(board) ### REMEMBER TO PASS IN THE BOARD INSTANCE
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  attr_reader :board, :cursor

  def render
    system('clear')
    render_color_board
    # count = 0
    # loop do
    #   count += 1
    #   cursor.get_input
    #   system('clear')
    #   render_color_board(cursor.cursor_pos)
    #   break if count == 5
    # end

  end
  
  def render_color_board
    board_graphics = board.graphics  ## 2D array of symbols (0..7)
  
    (0..7).each do |row|
      (0..7).each do |col|
        pos = [row, col]
        current_piece = board_graphics[row][col]
  
        if pos == cursor.cursor_pos && col == 7
          puts " #{current_piece} ".colorize(:background => :green)
        elsif pos == cursor.cursor_pos && col < 7
          print " #{current_piece} ".colorize(:background => :green)
        else
          if row.even? == col.even? && col == 7
            puts " #{current_piece} ".colorize(:background => :white)
          elsif row.even? == col.even? && col < 7
            print " #{current_piece} ".colorize(:background => :white)
          elsif row.even? != col.even? && col == 7
            puts " #{current_piece} ".colorize(:background => :black)
          else
            print " #{current_piece} ".colorize(:background => :black)
          end
        end
      end
    end

  end

end
