require 'spec_helper'

module WorldSmith
  describe CommandProxy do
    def mock_command_class(name)
      command = double("#{name}_instance")
      command.should_receive(:call)

      Object.stub(:const_get) do
        klass = double("#{name.capitalize}Command")
        klass.stub(:new).and_return(command)
        klass
      end
    end

    it "calls the real command when invoked" do
      ::WorldSmith::Config = double()
      ::WorldSmith::Config.stub(:root_dir) { '/project_root' }

      command_name = 'quit'
      command_file = File.join(Config.root_dir, 'app', 'commands', command_name)
      command_class = mock_command_class(command_name)

      command_proxy = CommandProxy.new(command_name)
      command_proxy.should_receive(:require).with(command_file).and_return(command_class)
      command_proxy.call
    end

    it "raises an exception if the real command can't be found"
  end
end

