module WorldSmith
  class CommandRouter
    class NoRouteError < Exception; end

    class << self
      def routes
        @routes ||= RoutingTable.new
      end

      def route(command)
        routes.find(command) or
          raise NoRouteError.new("No route to '#{command}'.")
      end
    end
  end
end
