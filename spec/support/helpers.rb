module CommandProxyHelpers
  def mock_command_class(name, command=nil)
    if command.nil?
      command = double("#{name}_instance")
      command.should_receive(:call)
    end

    Object.stub(:const_get) do
      klass = double("#{name.capitalize}Command")
      klass.stub(:new).and_return(command)
      klass
    end
  end
end

