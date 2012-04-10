require 'yaml'

module WorldSmith
  class World
    attr_reader :rooms

    def initialize
      @rooms = []
    end

    def save(stream = nil)
      stream = stream || get_stream('w')
      YAML::dump(self, stream)
    end

    def load(stream = nil)
      stream = stream || get_stream('r')
      YAML::load(stream)
    end

    def add_room(room)
      @rooms << room
    end

    private
    def get_stream(mode)
      File.open(File.join(WorldSmith.root, 'db', 'world.yml'), mode)
    end
  end
end
