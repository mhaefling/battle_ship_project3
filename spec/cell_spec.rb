require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
    before(:each) do
        @cell = Cell.new("B4")
        @cell_1 = Cell.new("B4")
        @cell_2 = Cell.new("C3")
        @cruiser = Ship.new("Cruiser", 3)
    end

    describe '#instantiate' do
        it 'is a Cell' do
            expect(@cell).to be_a(Cell)
        end
    end

    describe '#initialize' do
        it 'has attributes' do
            expect(@cell.coordinate).to eq("B4")
        end
    end

    describe '#ship' do
        it 'checks if a cell space is occupied by a ship' do
            expect(@cell.ship).to be(nil)
        end
    end

    describe '#empty?' do
        it 'checks if a cell is empty' do
            expect(@cell.empty?).to be(true)
        end

        it 'returns false when a ship is placed' do
            @cell.place_ship(@cruiser)

            expect(@cell.ship).to eq(@cruiser)
            expect(@cell.empty?).to be(false)
        end       
    end

    describe '#place_ship' do
        it 'places a ship in a cell' do
            @cell.place_ship(@cruiser)

            expect(@cell.ship).to eq(@cruiser)
        end
    end

    describe '#fired_upon?' do
        it 'has not been fired upon yet' do
            expect(@cell.fired_upon?).to be(false)
        end
    end

    describe '#fire_upon' do
        it 'decreases ships health when fired upon, and updates fired_upon to true' do
            @cell.place_ship(@cruiser)
            @cell.fire_upon

            expect(@cell.ship.health).to eq(2)
            expect(@cell.fired_upon?).to be(true)
        end
    end

    describe '#render' do
        it 'puts "." if the cell has not been fired upon' do
            expect(@cell_1.render).to eq(".")
        end

        it 'puts "M" if the cell has been fired upon and does not contain a ship' do
            @cell_1.fire_upon

            expect(@cell_1.render).to eq("M")
        end

        it 'puts "S" if the cell has a ship placed, and has not been fired upon' do
            @cell_2.place_ship(@cruiser)

            expect(@cell_2.render).to eq(".")
            expect(@cell_2.render(true)).to eq("S")
        end

        it 'puts "H" if the cell has been fired upon and contains a ship' do
            @cell_2.place_ship(@cruiser)
            @cell_2.fire_upon

            expect(@cell_2.render).to eq("H")
        end

        it 'puts "X" if the cell has been fired upon, and ship has been sunk' do
            @cell_2.place_ship(@cruiser)
            @cell_2.fire_upon
            expect(@cell_2.render).to eq("H")
            expect(@cruiser.sunk?).to be(false)

            @cruiser.hit
            @cruiser.hit

            expect(@cruiser.sunk?).to be(true)
            expect(@cell_2.render).to eq("X")
        end
    end
end