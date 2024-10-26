require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
    before(:each) do
        @board = Board.new
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
    end

    describe '#instantiate' do
        it 'is a board' do
            expect(@board).to be_a(Board)
        end
    end

    describe '#initialize' do
        it 'generates and keeps track of cells' do
            expect(@board.cells.count).to eq(16)
            expect(@board.cells).to be_a(Hash)
            expect(@board.cells["A1"]).to be_a(Cell)
            expect(@board.cells["D4"]).to be_a(Cell)
        end
    end

    describe '#valid_coordinate?' do
        it 'validates that a coordinate exists' do
            expect(@board.valid_coordinate?("A1")).to be(true)
            expect(@board.valid_coordinate?("D4")).to be(true)
            expect(@board.valid_coordinate?("A5")).to be(false)
            expect(@board.valid_coordinate?("E1")).to be(false)
            expect(@board.valid_coordinate?("A22")).to be(false)
        end
    end

    describe '#valid_placement?' do
        it 'verifies coordinates in the array are the same length as the ship' do
            expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to be(false)
            expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to be(false)
        end

        it 'verifies the coordinates are consecutive and horizontal on the board' do
            expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to be(false)
            expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to be(false)
            expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to be(false)
            expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to be(false)
            expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A3"])).to be(true)
        end

        it 'can NOT have a ship placed diagonally' do
            expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to be(false)
            expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to be(false)
            expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A3"])).to be(true)
        end

        it 'can have a ship placed vertically or horizontally' do
            expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to be(true)
            expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to be(true)
        end
    end

    describe '#place' do
        it 'verifying the board is tracking which cells the ship is placed on' do
            @board.place(@cruiser, ["A1", "A2", "A3"])

            expect(cell_1 = @board.cells["A1"]).to be_a(Cell)
            expect(cell_2 = @board.cells["A2"]).to be_a(Cell)
            expect(cell_3 = @board.cells["A3"]).to be_a(Cell)
            expect(cell_1.ship).to eq(@cruiser)
            expect(cell_2.ship).to eq(@cruiser)
            expect(cell_3.ship).to eq(@cruiser)
        end

        it 'verifies multiple cells contain the same ship object' do
            @board.place(@cruiser, ["A1", "A2", "A3"])
            cell_1 = @board.cells["A1"]
            cell_2 = @board.cells["A2"]
            cell_3 = @board.cells["A3"]

            expect(cell_3.ship == cell_2.ship).to be(true)
        end

        it 'verifies that ships are not overlapping' do
            @board.place(@cruiser, ["A1", "A2", "A3"])

            expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to be(false)
            expect(@board.valid_placement?(@submarine, ["B1", "B2"])).to be(true)
            
        end
    end
end