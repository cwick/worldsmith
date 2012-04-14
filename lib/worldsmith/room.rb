module WorldSmith
  module RoomSerializer
    def encode_with(c)
      c["exits"] = Hash[@exits.collect do |direction, room|
        [direction.to_s, room.id]
      end]
      c["id"] = self.id
    end

    def init_with(c)
      @id = c["id"]
      @exits = {}

      c["exits"].each do |direction, room_id|
        @exits[direction.to_sym] = room_id
      end
    end

    def dereference_ids(world)
      @exits.each do |direction, room_id|
        @exits[direction] = world.find_room_by_id(room_id)
      end
    end
  end

  class Room
    Limbo = Class.new

    include RoomSerializer
    attr_reader :id
    attr_reader :world

    def initialize
      @exits = {}
    end

    def id=(value)
      raise "Room ID cannot be set after linking to a world" if world
      @id = value
    end

    def world=(value)
      raise "Room is already linked to a world" if world
      @world = value
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

    def ==(other)
      self.id == other.id
    end
  end
end
