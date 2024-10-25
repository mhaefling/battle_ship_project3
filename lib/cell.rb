class Cell
    attr_reader :coordinate, :ship

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @empty = true
        @fired_upon = false
        @render = "."
    end

    def empty?
        if @ship != nil
            @empty = false
        end
        @empty
    end

    def place_ship(ship_type)
        @ship = ship_type
    end

    def fired_upon?
        @fired_upon
    end

    def fire_upon
        if empty? == false
            @ship.hit
            @fired_upon = true   
        else
            @fired_upon = true
        end
    end

    def render(check_ship = false)
        if empty? && fired_upon? 
            @render = "M"
        elsif check_ship == true
            empty? == false 
            @render = "S"
        elsif fired_upon? && ship.sunk? == true
            @render = "X"
        elsif empty? == false && fired_upon? == true
            @render = "H"
        end
        @render
    end
end