require_relative "stepable"
require_relative "piece"

class King < Piece
  include Stepable

  def symbol
    if self.color == :white
      symbol = "\u2654"
    else
      symbol = "\u265a"
    end
    symbol.encode('utf-8')
  end

  protected
  def move_diffs
    ### list of possible moves
    steps = [
      [-1,0],  ### 12 o'clock
      [-1,1],
      [0,1], ### 3 o'clock
      [1,1],
      [1,0], ### 6 o'clock
      [1,-1],
      [0,-1], ### 9 o'clock
      [-1,-1]
    ]
  end
end