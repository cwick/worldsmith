module WorldSmith
  class Command
    attr_reader :env

    def initialize(env)
      @env = env
    end

    def current_player
      env[:current_player]
    end
  end
end
