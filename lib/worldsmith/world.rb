require 'yaml'

module WorldSmith
  class World
    attr_reader :rooms

    def initialize
      @rooms = []
      @next_id = 1
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
      room.instance_variable_set("@id", @next_id)
      @next_id += 1
      @rooms << room
    end

    private
    def self.get_stream(mode)
      File.open(File.join(WorldSmith.root, 'db', 'world.yml'), mode)
    end
  end
end
