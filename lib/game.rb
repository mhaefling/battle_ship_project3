class Game

    attr_reader :player,
                :computer

    def initialize
        @player = {
            "board" => Board.new, 
            "cruiser" => Ship.new("Cruiser", 3), 
            "submarine" => Ship.new("Submarine", 2)
        }
        @computer = {
            "board" => Board.new, 
            "cruiser" => Ship.new("Cruiser", 3), 
            "submarine" => Ship.new("Submarine", 2)
        }
    end

    def start_game(user_input)
        if user_input == 'p'
            puts "Please wait while the other player places their ships."
            computer_place_ships

        elsif user_input == 'q'
            puts "Game canceled."

        else puts "Invalid input."
        end
    end

    def computer_place_ships
        loop do
            random_cords = @computer["board"].cells.keys.sample(3).sort
            validate = @computer["board"].valid_placement?(@computer["cruiser"], random_cords)
            # require 'pry'; binding.pry
            if validate == true
                @computer["board"].place(@computer["cruiser"], random_cords)
                break
            else
                random_cords.clear
            end
        end
        puts @computer["board"].render(true)
    end
end