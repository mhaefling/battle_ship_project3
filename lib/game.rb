class Game

    def initialize
    end

    def start_game(user_input)
        if user_input == 'p'
            puts "Game Started."

        elsif user_input == 'q'
            puts "Game canceled."

        else puts "Invalid input."
        end
    end

end