require 'singleton'
require_relative 'piece'

class NullPiece < Piece
  include Singleton
  
  def symbol
    " "
  end

  def initialize
    super(nil, "", "")
  end

  def moves
    []
  end

end