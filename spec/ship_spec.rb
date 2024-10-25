require './lib/ship'

RSpec.describe Ship do
	before(:each) do
		cruiser = Ship.new("Cruiser", 3)
	end

  describe '#instantiate' do
		it 'is a ship' do
			expect(cruiser).to be_a(Ship)
		end
	end

	describe '#initalize' do
		it 'has attributes' do
			expect(cruiser.name).to eq("Cruiser")
			expect(cruiser.length).to eq(3)
		end
	end

	describe '#health' do
		it 'has health' do
			expect(cruiser.health).to eq(3)
		end
	end

	describe '#sunk?' do
		it 'starts as not sunk' do
			expect(cruiser.sunk?).to be(false)
		end
	end

	describe '#hit' do
		it 'decreases ships health by one' do


		end
	end
end

