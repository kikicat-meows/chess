require_relative '../interface/display'

class HumanPlayer

    attr_reader :color, :display

    def initialize(color, display)
        @color = color
        @display = display
    end

    def make_move(board)
        start_pos = nil
        end_pos = nil

        until start_pos && end_pos
            display.render
            
            if start_pos
                puts "Where would you like to move it to?"
                end_pos = display.cursor.get_input
            else
                puts "#{color} player's turn."
                puts "Select a piece to move."
                puts "Please note that black pieces start at the top, white at the bottom."
                start_pos = display.cursor.get_input
            end
        end

        [start_pos, end_pos]   
    end             

end