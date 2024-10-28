class Game

    attr_reader :player,
                :computer

    def initialize
        @player = {
            "board" => Board.new, 
            "cruiser" => Ship.new("Cruiser", 3), 
            "submarine" => Ship.new("Submarine", 2)
        }
        @player_shots_taken = []
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

    def display_boards
        puts " "
        puts "=============COMPUTER BOARD============="
        puts @computer["board"].render
        puts "==============PLAYER BOARD=============="
        puts @player["board"].render(true)
        puts " "
    end

    def player_shot
        puts "Enter the coordinate for your shot: "
        puts " "
        player_shot = gets.chomp
        puts " "

        until !@player_shots_taken.include?(player_shot)
            puts "You have already fired on this cell, please choose another: "
            player_shot = gets.chomp
            @player_shots_taken.include?(player_shot)
        end

        until @computer["board"].cells.include?(player_shot)     
            puts "Please enter a valid coordinate: "
            player_shot = gets.chomp
            @computer["board"].cells.include?(player_shot)  
        end
        @computer["board"].cells[player_shot].fire_upon

        if @computer["board"].cells[player_shot].render == "X"
            puts "You have sunk my #{@computer["board"].cells[player_shot].ship.name}!"
            @player_shots_taken << player_shot

        elsif @computer["board"].cells[player_shot].render == "H"
            puts "You're shot on #{player_shot} was a hit!"
            @player_shots_taken << player_shot

        elsif @computer["board"].cells[player_shot].render == "M"
            puts "You're shot on #{player_shot} was a miss!"
            @player_shots_taken << player_shot
        end
    end
end