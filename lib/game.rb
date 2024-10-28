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
            puts "Please wait while the computer places its ships."
            computer_place_ships
            puts " "
            puts """I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long."""
            puts " "
            puts @player["board"].render


        elsif user_input == 'q'
            puts "Game canceled."

        else puts "Invalid input."
        end
    end

    def computer_place_ships
        loop do
            random_cords = @computer["board"].cells.keys.sample(3).sort
            if @computer["board"].valid_placement?(@computer["cruiser"], random_cords)
                @computer["board"].place(@computer["cruiser"], random_cords)
                break

            else
                random_cords.clear
            end
        end

        loop do
            random_cords = @computer["board"].cells.keys.sample(2).sort
            if @computer["board"].valid_placement?(@computer["submarine"], random_cords)
                @computer["board"].place(@computer["submarine"], random_cords)
                break

            else
                random_cords.clear
            end
        end
    end

    def player_place_cruiser(user_cruiser_placement)
        cruiser_cords_array = user_cruiser_placement.split(" ")

        until @player["board"].valid_placement?(@player["cruiser"], cruiser_cords_array)
            puts "Those are invalid coordinates. Please try again: "
            user_cruiser_placement = gets.chomp
            cruiser_cords_array = user_cruiser_placement.split(" ")
            @player["board"].valid_placement?(@player["cruiser"], cruiser_cords_array)
        end
        @player["board"].place(@player["cruiser"], cruiser_cords_array)
    end

    def player_place_submarine(user_submarine_placement)
        submarine_cords_array = user_submarine_placement.split(" ")

        until @player["board"].valid_placement?(@player["submarine"], submarine_cords_array)
            puts "Those are invalid coordinates. Please try again: "
            user_submarine_placement = gets.chomp
            submarine_cords_array = user_submarine_placement.split(" ")
            @player["board"].valid_placement?(@player["submarine"], submarine_cords_array)
        end
        @player["board"].place(@player["submarine"], submarine_cords_array)
    end
end