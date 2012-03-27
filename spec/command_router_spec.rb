require 'spec_helper'

module WorldSmith
  describe CommandRouter do
    it "finds the correct handler for a command" do
      CommandRouter.routes.should_receive(:find).
        with(:quit).
        and_return { Struct.new(:name).new("quit") }

      handler = CommandRouter.route(:quit)
      handler.name.should == "quit"
    end

    it "raises an exception when invoking a route that doesn't exist" do
      lambda do
        CommandRouter.route(:does_not_exist)
      end.should raise_error(NoRouteError)
    end
  end
end

