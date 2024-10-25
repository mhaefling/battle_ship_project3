class Cell
    attr_reader :coordinate, :ship

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @empty = true
        @fired_upon = false
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
        @ship.hit
        @fired_upon = true
    end
end