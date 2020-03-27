### able to move with restricted steps using Steppable
require_relative "stepable"
require_relative "piece"

class Knight < Piece
  include Stepable

  def symbol
    if self.color == :white
      symbol = "\u2658"
    else
      symbol = "\u265e"
    end
    symbol.encode('utf-8')
  end

  protected
  def move_diffs
    ### list of possible moves copy from knights travail
    steps = [
    [-2,-1],
    [-2,1],
    [2,-1],
    [2,1],
    [-1,-2],
    [-1,2],
    [1,-2],
    [1,2]
    ]
  end
end