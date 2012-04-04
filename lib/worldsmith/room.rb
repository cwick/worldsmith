module WorldSmith
  class Room
    Limbo = Class.new

    def initialize
      @exits = {}
    end

    def add_exit(name, other_room = Room::Limbo)
      if @exits.include?(name)
        raise ArgumentError.new("Exit '#{name.to_s}' already present in this room")
      end

      @exits[name] = other_room
    end

    def through_exit(name)
      @exits[name] or raise NoExitError.new("No connection via exit '#{name}'")
    end

    def has_exit?(name)
      @exits.include?(name)
    end
  end
end
