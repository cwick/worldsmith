require 'spec_helper'

module WorldSmith
  describe CommandProxy do
    include CommandProxyHelpers

    before do
      WorldSmith.stub(:root) { '/project_root' }
    end

    it "calls the real command when invoked" do
      command_name = 'quit'
      command_file = File.join(WorldSmith.root, 'app', 'commands', "#{command_name}_command")
      command_class = mock_command_class(command_name)

      command_proxy = CommandProxy.new(command_name)
      command_proxy.should_receive(:require).with(command_file)
      command_proxy.call
    end

    it "raises an exception if the real command can't be found" do
      command_proxy = CommandProxy.new('doesnt_exist')
      command_proxy.stub(:require).and_raise(LoadError)

      lambda { command_proxy.call }.should raise_error(NoCommandError)
    end

    it "passes the environment along to the real command" do
      command_proxy = CommandProxy.new('hello')
      command_proxy.stub(:require)
      env = { foo: 'bar' }

      command = double('HelloCommand')
      command.stub(:call) {
        env.should == env
      }
      mock_command_class('hello', command)

      command_proxy.env = env
      command_proxy.call
    end
  end
end

