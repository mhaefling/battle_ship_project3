class Cell
    attr_reader :coordinate, :ship

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @empty = true
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
end