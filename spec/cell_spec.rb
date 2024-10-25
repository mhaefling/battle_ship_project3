require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
    before(:each) do
        @cell = Cell.new("B4")
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
    end
end