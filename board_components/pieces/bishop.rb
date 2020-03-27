### able to move in a straight line using slideable 
require_relative "slideable"
require_relative "piece"

class Bishop < Piece
  include Slideable

  def symbol
    if self.color == :white
      symbol = "\u2657"
    else
      symbol = "\u265d"
    end
    symbol.encode('utf-8')
  end

  protected
  def move_dirs
    diagonal
  end
end

