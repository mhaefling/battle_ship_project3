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

    # We intentionally did not write a test for the start_game method because we cannot test for user input.
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
            exit 
            
        else 
            puts "Invalid input."
            load 'runner.rb'
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
        cruiser_cords_array = user_cruiser_placement.upcase.split(" ")

        until cruiser_cords_array.all? { |cord| @player["board"].valid_coordinate?(cord) } && @player["board"].valid_placement?(@player["cruiser"], cruiser_cords_array) && cruiser_cords_array.count == 3
            puts "Those are invalid coordinates. Please try again: "
            user_cruiser_placement = gets.chomp
            cruiser_cords_array = user_cruiser_placement.upcase.split(" ")
            cruiser_cords_array.all? { |cord| @player["board"].valid_coordinate?(cord) } && @player["board"].valid_placement?(@player["cruiser"], cruiser_cords_array) && cruiser_cords_array.count == 3
        end
        @player["board"].place(@player["cruiser"], cruiser_cords_array)
    end

    def player_place_submarine(user_submarine_placement)
        submarine_cords_array = user_submarine_placement.upcase.split(" ")

        until submarine_cords_array.all? { |cord| @player["board"].valid_coordinate?(cord) } && @player["board"].valid_placement?(@player["submarine"], submarine_cords_array) && submarine_cords_array.count == 2
            puts "Those are invalid coordinates. Please try again: "
            user_submarine_placement = gets.chomp
            submarine_cords_array = user_submarine_placement.upcase.split(" ")
            submarine_cords_array.all? { |cord| @player["board"].valid_coordinate?(cord) } && @player["board"].valid_placement?(@player["submarine"], submarine_cords_array) && submarine_cords_array.count == 2
        end
        @player["board"].place(@player["submarine"], submarine_cords_array)
    end

    def display_boards
        puts " "
        puts "=" * 13 + "COMPUTER BOARD" + "=" * 13
        puts @computer["board"].render
        puts "=" * 13 + "PLAYER BOARD" + "=" * 13
        puts @player["board"].render(true)
        puts " "
    end

    # We intentionally did not write a test for the player_shot method because we cannot test for user input.
    def player_shot
        puts "Enter the coordinate for your shot: "
        puts " "
        player_shot = gets.chomp.upcase
        puts " "
        
        until @computer["board"].valid_coordinate?(player_shot)     
            puts "Please enter a valid coordinate: "
            player_shot = gets.chomp.upcase
            @computer["board"].valid_coordinate?(player_shot)  
        end

        until !@computer["board"].cells[player_shot].fired_upon?
            puts "You have already fired on this cell, please choose another: "
            player_shot = gets.chomp.upcase
            @computer["board"].cells[player_shot].fired_upon?
        end
        @computer["board"].cells[player_shot].fire_upon

        if @computer["board"].cells[player_shot].render == "X"
            puts "You have sunk my #{@computer["board"].cells[player_shot].ship.name}!"
            @computer["board"].cells[player_shot].fired_upon?

        elsif @computer["board"].cells[player_shot].render == "H"
            puts "Your shot on #{player_shot} was a hit!"
            @computer["board"].cells[player_shot].fired_upon?

        elsif @computer["board"].cells[player_shot].render == "M"
            puts "Your shot on #{player_shot} was a miss!"
            @computer["board"].cells[player_shot].fired_upon?
        end
    end

    def computer_shot
        computer_shot = @player["board"].cells.keys.sample

        until !@player["board"].cells[computer_shot].fired_upon?
            puts "Computer has already fired on this cell, it will choose another."
            computer_shot = @player["board"].cells.keys.sample
            @player["board"].cells[computer_shot].fired_upon?
        end
        @player["board"].cells[computer_shot].fire_upon

        if @player["board"].cells[computer_shot].render == "X"
            puts "I have sunk your #{@player["board"].cells[computer_shot].ship.name}!"
            @player["board"].cells[computer_shot].fired_upon?

        elsif @player["board"].cells[computer_shot].render == "H"
            puts "My shot on #{computer_shot} was a hit!"
            @player["board"].cells[computer_shot].fired_upon?

        elsif @player["board"].cells[computer_shot].render == "M"
            puts "My shot on #{computer_shot} was a miss!"
            @player["board"].cells[computer_shot].fired_upon?
        end
    end

    def winner
        
        if @player["cruiser"].sunk? && @player["submarine"].sunk?
            puts "I WON!"

        elsif @computer["cruiser"].sunk? && @computer["submarine"].sunk?
            puts "YOU WON!"
        end
    end
end