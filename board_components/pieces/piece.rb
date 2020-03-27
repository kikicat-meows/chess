require_relative "slideable"  ### HAD TO IMPORT THIS TO MAKE VALID_MOVES WORK

class Piece
  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
  end

  def to_s  ### symbols are already strings
    self.symbol.to_s
  end
  
  def pos=(val)
    @pos = val if board.valid_pos?(val)
  end

  def valid_moves
  ### get moves array from moves
    moves_arr = self.moves
  ### loop through the moves array each set of coords
    moves_arr.reject { |pos| move_into_check?(pos) }
  ### check coords in move_into_check?(end_pos)
  ### return selected array
    
  end

  def move_into_check?(end_pos)
  ### calls board.dupe
    duped_board = @board.duped  ### Duped board instance
  ### use board.move_piece!(pos, end_pos) to move piece to new coord (USE THIS AS IT DOESNT CHECK)
  ### MUST BE DUPED BOARD, NOT REAL BOARD
    duped_board.move_piece!(@pos, end_pos)
  ### call board.in_check?(self.color) for DUPED BOARD
    duped_board.in_check?(@color)
  ### RETURN BOOLEAN
  end

  def moves
    '' ### no real moves, will be individual in class (generates array of moves)
  end

  def symbol
    '' ### overwrite in each class
  end

  attr_reader :board, :color, :pos
end