module WorldSmith
  class CommandProxy
    def initialize(command)
      @command = command.to_s
    end

    def call
      require File.join(Config.root_dir, 'app', 'commands', @command)
      Object.const_get("#{@command.capitalize}Command").new.call
    end
  end
end
