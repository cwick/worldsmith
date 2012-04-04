module WorldSmith
  class Player
    def initialize
      @location = Room::Limbo
    end

    attr_accessor :location
  end
end

