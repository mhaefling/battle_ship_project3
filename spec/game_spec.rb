require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
    before(:each) do
        @game = Game.new
    end

    describe '#instantiate' do
        it 'is a game' do

            expect(@game).to be_a(Game)
            expect(@game.player).to be_a(Hash)
            expect(@game.computer).to be_a(Hash)
            expect(@game.player["board"]).to be_a(Board)
            expect(@game.player["cruiser"]).to be_a(Ship)
            expect(@game.player["submarine"]).to be_a(Ship)
            expect(@game.computer["board"]).to be_a(Board)
            expect(@game.computer["cruiser"]).to be_a(Ship)
            expect(@game.computer["submarine"]).to be_a(Ship)
        end
    end

    describe '#computer_place_ships' do
        it 'checks if random_cords is an array containing 3 coordinates' do
            @game.computer["board"].cells.keys.sample(3).sort

            expect(@game.computer["board"].cells.keys.sample(3).sort).to be_an(Array)
            expect(@game.computer["board"].cells.keys.sample(3).sort.count).to eq(3)
        end

        it 'checks if random_cords is an array containing 2 coordinates' do
            @game.computer["board"].cells.keys.sample(2).sort

            expect(@game.computer["board"].cells.keys.sample(2).sort).to be_an(Array)
            expect(@game.computer["board"].cells.keys.sample(2).sort.count).to eq(2)
        end

        it 'checks if the computer is placing the cruiser on the board' do
            example_cords = ["A1", "A2", "A3"]

            @game.computer["board"].valid_placement?(@game.computer["cruiser"], example_cords)

            expect(@game.computer["board"].valid_placement?(@game.computer["cruiser"], example_cords)).to be(true)

            @game.computer["board"].place(@game.computer["cruiser"], example_cords)

            expect(@game.computer["board"].cells["A1"].empty?).to be(false)
            expect(@game.computer["board"].cells["A2"].empty?).to be(false)
            expect(@game.computer["board"].cells["A3"].empty?).to be(false)
        end

        it 'checks if the computer is placing the submarine on the board in valid coordinates' do
            example_cords = ["A1", "A2"]

            @game.computer["board"].valid_placement?(@game.computer["submarine"], example_cords)

            expect(@game.computer["board"].valid_placement?(@game.computer["submarine"], example_cords)).to be(true)

            @game.computer["board"].place(@game.computer["submarine"], example_cords)

            expect(@game.computer["board"].cells["A1"].empty?).to be(false)
            expect(@game.computer["board"].cells["A2"].empty?).to be(false)
        end
    end

    describe '#player_place_cruiser(banana)' do
        it 'checks if the player placed the cruiser on 3 selected (and valid) coordinates' do
            example_cords = ["A1", "A2", "A3"]

            @game.player["board"].valid_placement?(@game.player["cruiser"], example_cords) && example_cords.count == 3

            expect(@game.player["board"].valid_placement?(@game.player["cruiser"], example_cords)).to be(true)
            expect(example_cords.count).to eq(3)

            @game.player["board"].place(@game.player["cruiser"], example_cords)

            expect(@game.player["board"].cells["A1"].empty?).to be(false)
            expect(@game.player["board"].cells["A2"].empty?).to be(false)
            expect(@game.player["board"].cells["A3"].empty?).to be(false)
        end
    end

    describe '#player_palce_submarine(banana)' do
        it 'checks if the player placed the submarine on 2 selected (and valid) coordinates' do
            example_cords = ["A1", "A2"]

            @game.player["board"].valid_placement?(@game.player["submarine"], example_cords) && example_cords.count == 2

            expect(@game.player["board"].valid_placement?(@game.player["submarine"], example_cords)).to be(true)
            expect(example_cords.count).to eq(2)

            @game.player["board"].place(@game.player["cruiser"], example_cords)

            expect(@game.player["board"].cells["A1"].empty?).to be(false)
            expect(@game.player["board"].cells["A2"].empty?).to be(false)
        end
    end

    describe '#display_boards' do
        it 'renders the computer and player boards and shows the players ships on their own board' do
            example_cords = ["A1", "A2"]
            @game.player["board"].place(@game.player["cruiser"], example_cords)

            expect(@game.computer["board"].render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
            
            expect(@game.player["board"].render(true)).to eq("  1 2 3 4 \nA S S . . \nB . . . . \nC . . . . \nD . . . . \n")
        end
    end

    describe '#player_shot' do
        it 'has the user make a shot on a cell and displays M on the computers board if it is a miss' do
            example_cords = ["A1", "A2"]

            @game.computer["board"].place(@game.computer["submarine"], example_cords)
            expect(@game.computer["board"].render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")

            @game.computer["board"].cells["A3"].fire_upon

            expect(@game.computer["board"].valid_coordinate?("A3")).to be(true)
            expect(@game.computer["board"].render).to eq("  1 2 3 4 \nA . . M . \nB . . . . \nC . . . . \nD . . . . \n")
        end

        it 'has the user make a shot on a cell and displays H on the computers board if it is a hit' do
            example_cords = ["A1", "A2"]

            @game.computer["board"].place(@game.computer["submarine"], example_cords)
            expect(@game.computer["board"].render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")

            @game.computer["board"].cells["A2"].fire_upon

            expect(@game.computer["board"].valid_coordinate?("A2")).to be(true)
            expect(@game.computer["board"].render).to eq("  1 2 3 4 \nA . H . . \nB . . . . \nC . . . . \nD . . . . \n")
        end

        it 'has the user make a shot on a cell and displays X on the computers board if the ship is sunk' do
            example_cords = ["A1", "A2"]

            @game.computer["board"].place(@game.computer["submarine"], example_cords)
            expect(@game.computer["board"].render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")

            @game.computer["board"].cells["A1"].fire_upon
            @game.computer["board"].cells["A2"].fire_upon

            expect(@game.computer["board"].valid_coordinate?("A1")).to be(true)
            expect(@game.computer["board"].valid_coordinate?("A2")).to be(true)
            expect(@game.computer["board"].render).to eq("  1 2 3 4 \nA X X . . \nB . . . . \nC . . . . \nD . . . . \n")
        end

        it 'does not allow a player to take a shot on a cell that was already fired upon.' do
            example_cords = ["A1", "A2"]
            @game.computer["board"].place(@game.computer["submarine"], example_cords)

            @game.computer["board"].cells["A1"].fire_upon

            expect(@game.computer["board"].cells["A1"].fired_upon?).to be(true)
            
            @game.computer["board"].cells["A1"].fire_upon

           #expect{@game.player_shot}.to output("You have already fired on this cell, please choose another: ").to_stdout
        end

        it 'makes sure the player is taking a shot on a valid coordinate' do
            example_cords = ["A1", "A2"]
            @game.computer["board"].place(@game.computer["submarine"], example_cords)

            @game.computer["board"].cells["A1"].fire_upon

            expect(@game.computer["board"].valid_coordinate?("A1") ).to be(true)
        end
    end
    
    describe '#computer_shot' do
        it 'has the computer make a shot on a cell and displays M on the players board if it is a miss' do
            example_cords = ["A1", "A2"]

            @game.player["board"].place(@game.player["submarine"], example_cords)
            expect(@game.player["board"].render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")

            @game.player["board"].cells["A3"].fire_upon

            expect(@game.player["board"].valid_coordinate?("A3")).to be(true)
            expect(@game.player["board"].render).to eq("  1 2 3 4 \nA . . M . \nB . . . . \nC . . . . \nD . . . . \n")
        end

        it 'has the computer make a shot on a cell and displays H on the players board if it is a hit' do
            example_cords = ["A1", "A2"]

            @game.player["board"].place(@game.player["submarine"], example_cords)
            expect(@game.player["board"].render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")

            @game.player["board"].cells["A2"].fire_upon

            expect(@game.player["board"].valid_coordinate?("A2")).to be(true)
            expect(@game.player["board"].render).to eq("  1 2 3 4 \nA . H . . \nB . . . . \nC . . . . \nD . . . . \n")
        end

        it 'has the computer make a shot on a cell and displays X on the players board if the ship is sunk' do
            example_cords = ["A1", "A2"]

            @game.player["board"].place(@game.player["submarine"], example_cords)
            expect(@game.player["board"].render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")

            @game.player["board"].cells["A1"].fire_upon
            @game.player["board"].cells["A2"].fire_upon

            expect(@game.player["board"].valid_coordinate?("A1")).to be(true)
            expect(@game.player["board"].valid_coordinate?("A2")).to be(true)
            expect(@game.player["board"].render).to eq("  1 2 3 4 \nA X X . . \nB . . . . \nC . . . . \nD . . . . \n")
        end

        it 'does not allow the computer to take a shot on a cell that was already fired upon.' do
            example_cords = ["A1", "A2"]
            @game.player["board"].place(@game.player["submarine"], example_cords)

            @game.player["board"].cells["A1"].fire_upon

            expect(@game.player["board"].cells["A1"].fired_upon?).to be(true)
            
            @game.player["board"].cells["A1"].fire_upon

        #expect{@game.computer_shot}.to output("Computer has already fired on this cell, it will choose another.").to_stdout
        end

        it 'makes sure the computer is taking a shot on a valid coordinate' do
            example_cords = ["A1", "A2"]
            @game.player["board"].place(@game.player["submarine"], example_cords)

            @game.player["board"].cells["A1"].fire_upon

            expect(@game.player["board"].valid_coordinate?("A1") ).to be(true)
        end
    end

    describe '#winner' do
        it 'determines if the player is the winner of the game' do
            cruiser_cords = ["A1", "A2", "A3"]
            sub_cords = ["B1", "C1"]

            @game.computer["board"].place(@game.computer["cruiser"], cruiser_cords)
            @game.computer["board"].place(@game.computer["submarine"], sub_cords)

            @game.computer["cruiser"].hit
            @game.computer["cruiser"].hit
            @game.computer["cruiser"].hit

            expect(@game.computer["cruiser"].sunk?).to be(true)

            @game.computer["submarine"].hit
            @game.computer["submarine"].hit

            expect(@game.computer["submarine"].sunk?).to be(true)
        end
    

        it 'determines if the computer is the winner of the game' do
            player_cruiser_cords = ["A1", "A2", "A3"]
            player_sub_cords = ["B1", "C1"]

            @game.player["board"].place(@game.player["cruiser"], player_cruiser_cords)
            @game.player["board"].place(@game.player["submarine"], player_sub_cords)

            @game.player["cruiser"].hit
            @game.player["cruiser"].hit
            @game.player["cruiser"].hit

            expect(@game.player["cruiser"].sunk?).to be(true)

            @game.player["submarine"].hit
            @game.player["submarine"].hit

            expect(@game.player["submarine"].sunk?).to be(true)
        end
    end
end

