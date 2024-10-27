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
        end
    end

    describe '#start_game' do
        it 'starts the game' do

            expect(@game.start_game(user_input)).to eq("Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.")
        end
    end
end

