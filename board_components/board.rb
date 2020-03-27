require_relative "pieces"
require "set"

class Board
  def initialize(populate = true)  
    ##populate to be a boolean method indicating whether if we only want @board space, or if we want to fill it with Pieces as well

    ### amend below so that board grid is generated first, before pieces are placed in as we need to pass board information to piece
    @board = Array.new(8) {Array.new(8) {nil} }

    populate_board if populate == true
  end
  
  attr_reader :board
  
  def [](pos)
    row, col = pos
    board[row][col]
  end
  
  def []=(pos, val)
    row, col = pos
    board[row][col] = val
  end

  def pieces 
    ###will hold the pieces in an Array so it's easier to search for king and for enemy moves
    pieces = []

    board.each do |row|
      row.each do |piece|
        pieces << piece if !piece.is_a?(NullPiece)
      end
    end

    pieces
  end

  def duped 
    ### need to initiate a new Board completely...shovelling into new array can only generate new object_id but not a board.class
    ### fill board piece by piece with current layout
    # failed attempt
    # board.each do |row|
    #   dup_row = []
    
    #   row.each do |piece|
    #     dup_row << piece.class.new()
    #   end
    
    #   duped << dup_row
    # end

    ### WORKED, checked object_id, moved around the king piece, looked for it, checked pieces.object_id, completely new board that works with all board functions

    
    duped = Board.new(false)
    
    (0..7).each do |row| ### row
      (0..7).each do |col| 
        pos = [row, col]
        piece = self[pos]

        if piece.is_a?(NullPiece)
          duped[pos] = NullPiece.instance
        else
          duped[pos] = piece.class.new(duped,piece.color,piece.pos)
        end
      end
    end

    duped
  end
  
  def move_piece(color,start_pos, end_pos)
    raise "That is not your piece" if color != self[start_pos].color
    raise "Start position not on board, please check your input" if !valid_pos?(start_pos)
    raise "Target location invalid, please check your input again" if !valid_pos?(end_pos)
    raise "There is no piece at start_pos" if empty?(start_pos)
    
    selected_piece = self[start_pos]
    
    # selected_piece.pos = end_pos
    # self[end_pos], self[start_pos] = selected_piece, NullPiece.instance
    if !selected_piece.moves.include?(end_pos)
      raise "The selected piece cannot move to the target location."
    elsif !selected_piece.valid_moves.include?(end_pos)
      raise "Invalid move --> this will put you in check."
    end

    move_piece!(start_pos, end_pos)
  end

  def move_piece!(start_pos, end_pos)
    # raise "Start position not on board, please check your input" if !valid_pos?(start_pos)
    # raise "Target position invalid, please check your input again" if !valid_pos?(end_pos)
    # raise "There is no piece at start_pos" if self[start_pos].color == :null  
    
    selected_piece = self[start_pos]

    selected_piece.pos = end_pos
    self[end_pos], self[start_pos] = selected_piece, NullPiece.instance
    
  end
  
  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def empty?(pos)  ### PH, might have to amend later when NULL COLOR changes
    self[pos].color == "" ? true : false
  end

  def checkmate?(color)
    ### determine if player is in check in_check?(color)
    return false if !in_check?(color)

    # moves = []
    pieces.each do |piece|
      next if piece.color != color
      
      return false if !piece.valid_moves.empty?
      
    end
    
    # moves
    true
  end

  def in_check?(color)
    king_pos = find_king(color)
    enemy_moves = possible_enemy_moves(color) ## returns a Set
    return true if enemy_moves.include?(king_pos)

    false
  end

  def possible_enemy_moves(color)
    enemy_moves = Set.new

    pieces.each do |piece|
        next if piece.color == color
        piece.moves.each {|pos| enemy_moves << pos}
    end

    enemy_moves
  end

  def find_king(color)
    pieces.each { |piece| return piece.pos if piece.is_a?(King) && piece.color == color}
  end

  ### graphics for Display class to read all arrays instead of Board objects.
  def graphics
    board_graphics = []
    board.each do |row|
      symbolic_row = []
      row.each {|ele| symbolic_row << ele.to_s }
      board_graphics << symbolic_row
    end
    board_graphics
  end
  
  ### Clean this up last please
    


  def populate_board
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    black_back_row = []
    back_row.each_with_index do |piece_class, j|
      black_back_row << piece_class.new(self, :black, [0, j])
    end
    board[0] = black_back_row
  
    black_front_row = []
    (0..7).each {|idx| black_front_row << Pawn.new(self, :black, [1, idx])}
    board[1] = black_front_row
  
    (2..5).each do |row|
      board[row] = Array.new(8) {NullPiece.instance} 
    end
  
    white_front_row = []
    8.times {|idx| white_front_row << Pawn.new(self, :white, [6, idx])}
    board[6] = white_front_row
  
    white_back_row = []
    back_row.each_with_index do |piece_class, j|
      white_back_row << piece_class.new(self, :white, [7, j])
    end
    board[7] = white_back_row
  end

end

