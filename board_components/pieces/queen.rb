### able to move in a straight line using slideable 
require_relative "slideable"
require_relative "piece"

class Queen < Piece
  include Slideable
  def symbol
    if self.color == :white
      symbol = "\u2655"
    else
      symbol = "\u265b"
    end
    symbol.encode('utf-8')
  end

  # def valid_moves
  #   ### get moves array from moves
  #     moves_arr = self.moves
  #   ### loop through the moves array each set of coords
  #     moves_arr.reject { |pos| move_into_check?(pos) }
  #   ### check coords in move_into_check?(end_pos)
  #   ### return selected array
      
  # end

  protected
  def move_dirs
    linear + diagonal
  end
end