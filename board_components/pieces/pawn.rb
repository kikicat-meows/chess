require_relative "piece"

class Pawn < Piece
  def symbol
    if self.color == :white
      symbol = "\u2659"
    else
      symbol = "\u265f"
    end
    symbol.encode('utf-8')
  end

  def moves
    forward_steps + side_attacks
  end

  # private
  def at_start_row?
    row, col = pos

    return true if (color == :black && row == 1) || (color == :white && row == 6)
    false
  end

  def forward_dir
    color == :black ? 1 : -1
  end

  def forward_steps ## generate array of forward moves
    forward_moves = []
    cur_row, cur_col = pos
    ### probably something to do with at_start_row? boolean, if at_start_row? == true, 1 or 2 steps, else only 1 step?
    new_pos = [(cur_row + forward_dir), cur_col]

    forward_moves << new_pos if board.valid_pos?(new_pos) && board.empty?(new_pos)

    if at_start_row?
      double_step = [(cur_row + (2 * forward_dir)), cur_col]
      forward_moves << double_step if board.valid_pos?(double_step) && board.empty?(double_step)
    end

    forward_moves
  end

  def side_attacks ## generate array of side moves
    ### might have to check forward left and right side (so d_col = -1 or 1) if there's any pieces, if there's a piece of the OPPOSITE color, side_attack is possible
    ### not a boolean value
    moves = []
    row, col = pos

    ## potential enemies should be present at row + forward_dir, col +/- 1
    [-1, 1].each do |d_col|
      enemy_pos = [(row + forward_dir), (col + d_col)]
      
      if board.valid_pos?(enemy_pos)
        moves << enemy_pos if !board.empty?(enemy_pos) && board[enemy_pos].color != self.color
      end
    end
    moves
  end

end