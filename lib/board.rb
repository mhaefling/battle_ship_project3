class Board

    attr_reader :cells
    
    def initialize
        @cells = {
            "A1" => Cell.new("A1"),
            "A2" => Cell.new("A2"),
            "A3" => Cell.new("A3"),
            "A4" => Cell.new("A4"),
            "B1" => Cell.new("B1"),
            "B2" => Cell.new("B2"),
            "B3" => Cell.new("B3"),
            "B4" => Cell.new("B4"),
            "C1" => Cell.new("C1"),
            "C2" => Cell.new("C2"),
            "C3" => Cell.new("C3"),
            "C4" => Cell.new("C4"),
            "D1" => Cell.new("D1"),
            "D2" => Cell.new("D2"),
            "D3" => Cell.new("D3"),
            "D4" => Cell.new("D4")
        }
    end

    def valid_coordinate?(coordinate)
        @cells.key?(coordinate)
    end

    def valid_placement?(ship, coordinates)
        empty_cells = coordinates.all? do |coordinate|
            @cells[coordinate].empty?
        end

        length_count = ship.length == coordinates.count

        letter_match = coordinates.each_cons(2).all? do |coordinate0, coordinate1| 
            coordinate1[0] == coordinate0[0]
        end

        letter_sequence = coordinates.each_cons(2).all? do |coordinate0, coordinate1| 
            coordinate1[0].ord == coordinate0[0].ord + 1
        end

        num_sequence = coordinates.each_cons(2).all? do |coordinate0, coordinate1| 
            coordinate1[1].to_i == coordinate0[1].to_i + 1
        end


        if empty_cells && length_count && (letter_match && num_sequence)
            true

        elsif empty_cells && letter_sequence && !num_sequence
            true

        elsif length_count && letter_sequence && num_sequence
            false
            
        else
            false
        end
    end

    def place(ship, coordinates)
        coordinates.each do |coordinate|
            @cells[coordinate].place_ship(ship)
        end
    end
end