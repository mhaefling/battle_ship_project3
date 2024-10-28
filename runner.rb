require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

battle_ship = Game.new

puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
user_input = gets.chomp
battle_ship.start_game(user_input)

puts " "
puts "Enter the squares for the Cruiser (3 spaces):"
user_placement = gets.chomp
battle_ship.player_place_ships(user_placement)
if battle_ship.player_place_ships(user_placement) == false
    puts "Those are invalid coordinates. Please try again:"
    user_placement = gets.chomp
    battle_ship.player_place_ships(user_placement)
end