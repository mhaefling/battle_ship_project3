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

    def render
        if empty? && fired_upon? 
            @render = "M"
        end
        @render
    end
end