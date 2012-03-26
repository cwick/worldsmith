module WorldSmith
  class RoutingTable
    def initialize
      @entries = {}
    end

    def draw(&block)
      DSL.new(self).instance_eval &block
    end

    def entries
      @entries.dup.freeze
    end

    def find(name)
      @entries[name]
    end

    private
    def set_entry(key, value)
      @entries[key] = value
    end

    class DSL
      def initialize(table)
        @table = table
      end

      def command(name)
        @table.send(:set_entry,
                    name,
                    Struct.new(:name).new(name.to_s))
      end
    end
  end
end

