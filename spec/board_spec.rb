require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
    before(:each) do
        @board = Board.new
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
end