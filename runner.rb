require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

battle_ship = Game.new

puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."

user_input = gets.chomp

battle_ship.start_game(user_input)
