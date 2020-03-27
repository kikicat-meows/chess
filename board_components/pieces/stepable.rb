module Stepable

  ### copied from Knights Travails
  
  def moves ### takes in current position of piece
    valid_moves = []
    cur_row, cur_col = pos

    move_diffs.each do |(d_row, d_col)|
      new_pos = [cur_row + d_row, cur_col + d_col]

      if board.valid_pos?(new_pos)
        if !board.empty?(new_pos) && board[new_pos].color == self.color
          next
        else
          valid_moves << new_pos
        end
      end
    end

    valid_moves
  end

  private
  def move_diffs ### implement correct move direction
    ### This is in each SubClass
  end
end 