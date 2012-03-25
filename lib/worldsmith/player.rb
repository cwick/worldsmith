module WorldSmith
  class Player
    def initialize
      @current_room = Room::Limbo
    end

    attr_accessor :current_room
  end
end

