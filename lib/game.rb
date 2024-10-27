class Game

    attr_reader :player_board, :computer_board

    def initialize
        @player = {board: Board.new, cruiser: Ship.new("Cruiser", 3), submarine: Ship.new("Submarine", 2)}
        @computer = {board: Board.new, cruiser: Ship.new("Cruiser", 3), submarine: Ship.new("Submarine", 2)}
        require 'pry'; binding.pry
    end

    def start_game(user_input)
        if user_input == 'p'
            puts "Game Started."
            @player_board
            @computer_board

        elsif user_input == 'q'
            puts "Game canceled."

        else puts "Invalid input."
        end
    end

    def place_ships(ship, coordinates)
        3.times @computer[:board].cells.keys.sample do
        until valid_placement? == true
            false
        end
    end
end