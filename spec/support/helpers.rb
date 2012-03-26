module CommandProxyHelpers
  def mock_command_class(name)
    command = double("#{name}_instance")
    command.should_receive(:call)

    Object.stub(:const_get) do
      klass = double("#{name.capitalize}Command")
      klass.stub(:new).and_return(command)
      klass
    end
  end
end

