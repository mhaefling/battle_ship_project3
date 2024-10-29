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

user_cruiser_placement = gets.chomp
battle_ship.player_place_cruiser(user_cruiser_placement)

puts " "
puts "You have placed your Cruiser."
puts " "
puts "Now enter the squares for the Submarine (2 spaces): "

user_submarine_placement = gets.chomp
battle_ship.player_place_submarine(user_submarine_placement)

puts " "
puts "You have placed your Submarine."

until (battle_ship.computer["cruiser"].sunk? && battle_ship.computer["submarine"].sunk?) || (battle_ship.player["cruiser"].sunk? && battle_ship.player["submarine"].sunk?)
    battle_ship.display_boards
    battle_ship.player_shot
    battle_ship.computer_shot
end
battle_ship.display_boards
battle_ship.winner 
puts " "

puts "Do you want to play again? Yes or No"
puts " "
restart = gets.chomp.downcase
if restart == "yes"
    puts " "
    load 'runner.rb'
else
    puts "Thanks for playing!"
end