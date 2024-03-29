module WorldSmith
  class CommandProxy
    attr_accessor :env

    def initialize(command)
      @command = command.to_s
    end

    def name
      @command
    end

    def call
      command_file = File.join(WorldSmith.root, 'app', 'commands', "#{@command}_command")
      require_command(command_file)

      class_name = "#{@command.capitalize}Command"
      klass = get_command_class(class_name)
      klass.new(env).call
    end

    private
    def require_command(filename)
      begin
        require filename
      rescue LoadError
        # OK if command file doesn't exist
      end
    end

    def get_command_class(class_name)
      begin
        klass = Object.const_get(class_name)
      rescue NameError
        raise NoCommandError.new("Command '#{@command}' does not exist")
      end
    end
  end
end
