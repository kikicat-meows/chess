### able to move in a straight line using slideable 
require_relative "slideable"
require_relative "piece"

class Rook < Piece
  include Slideable

  def symbol
    if self.color == :white
      symbol = "\u2656"
    else
      symbol = "\u265c"
    end
    symbol.encode('utf-8')
  end

  protected
  def move_dirs
    linear
  end
end
