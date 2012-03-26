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
      end.should raise_error(CommandRouter::NoRouteError)
    end
  end

  describe RoutingTable do
    it "should have no routes initially" do
      subject.entries.should be_empty
    end

    it "should map a command to a handler" do
      subject.draw do
        command :quit
      end
      handler = subject.entries[:quit].name.should == "quit"
    end

    it "should be able to find a command" do
      subject.draw do
        command :quit
        command :die
      end

      subject.find(:quit).name.should == "quit"
    end
  end
end
