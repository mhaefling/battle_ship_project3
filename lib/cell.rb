class Cell
    attr_reader :coordinate, :ship, :render

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @empty = true
        @fired_upon = false
        @render = "."
    end

    def empty?
        @ship != nil ? @empty = false : @empty
        # if @ship != nil
        #     @empty = false
        # end
        # @empty
    end

    def place_ship(ship_type)
        @ship = ship_type
    end

    def fired_upon?
        @fired_upon
    end

    def fire_upon
        if !empty? 
            @ship.hit
            @fired_upon = true   
        else
            @fired_upon = true
        end
    end

    def render(check_ship = false)
        if fired_upon? && !empty? && ship.sunk?
            @render = "X"  
        
        elsif !empty? && fired_upon?
            @render = "H"

        elsif empty? && fired_upon? 
            @render = "M"  
    
        elsif check_ship == true && !empty? 
            @render = "S" 
        end
        @render
    end
end