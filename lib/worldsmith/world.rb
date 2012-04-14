require 'yaml'

module WorldSmith
  module WorldSerializer
    def encode_with(c)
      c['rooms'] = rooms.to_a
      c['next_id'] = @next_id
    end

    def init_with(c)
      @next_id = c['next_id']
      @rooms = {}

      c['rooms'].each { |room| add_room(room) }
      rooms.each { |room| room.dereference_ids(self) }
    end
  end

  class World
    include WorldSerializer

    def initialize
      @rooms = {}
      @next_id = 1
    end

    def rooms
      RoomCollection.new(@rooms)
    end

    def save(stream = nil)
      stream = stream || self.class.get_stream('w')
      YAML::dump(self, stream)
    end

    def self.load(stream = nil)
      stream = stream || get_stream('r')
      YAML::load(stream)
    end

    def add_room(room)
      if room.id.nil?
        room.id = @next_id
        @next_id += 1
      end

      room.world = self
      @rooms[room.id] = room
    end

    def find_room_by_id(id)
      @rooms[id] or raise RoomNotFoundError
    end

    private
    class RoomCollection
      include Enumerable

      def initialize(rooms)
        @rooms = rooms
      end

      def each(&block)
        @rooms.each do |_, room|
          yield room
        end
      end

      def ==(other)
        @rooms == other.rooms
      end

      protected
      attr_reader :rooms
    end

    def self.get_stream(mode)
      File.open(File.join(WorldSmith.root, 'db', 'world.yml'), mode)
    end
  end
end


