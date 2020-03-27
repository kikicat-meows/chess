require "byebug"
module Slideable
  LINEAR = [
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 0]
  ]

  DIAGONAL = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ]

  ### only methods can be passed in modules, therefore need these extra methods to retrieve the list of possible directions
  def linear
    LINEAR
  end

  def diagonal
    DIAGONAL
  end
  
  def moves
    valid_moves = []

    move_dirs.each do |dir|
      d_row, d_col = dir

      # debugger
      valid_moves += how_far_can_you_slide(d_row, d_col)
    end

    valid_moves
  end

  private

  def move_dirs
    ### overwritten by subclass *** chooses which of the directions is valid??
    ### ie Rook should only have linear
    ### Bishop should only have diagonal
    ### Queen should be able to move all directions
  end
  
  def how_far_can_you_slide(d_row, d_col)
    ### recursive to check each direction (d_row, d_col) will dictate the direction

    ### queue will continue to extend that direction (updating current pos) until
    ### either the board ends, or it hits an opposite color (and takes the piece)

    ### to prevent confusion, hitting a piece of the same color will not have any
    ### effect as it won't be considered a possible move condition
    possible_moves = []
    queue = [pos]

    # debugger
    until queue.empty?
      cur_row, cur_col = queue.shift
      
      new_pos = [cur_row + d_row, cur_col + d_col]

      if board.valid_pos?(new_pos)
        
        if board.empty?(new_pos)
          possible_moves << new_pos
          queue << new_pos
        elsif !board.empty?(new_pos) && board[new_pos].color != self.color
          possible_moves << new_pos
        end
      end
    end

    possible_moves
  end
end