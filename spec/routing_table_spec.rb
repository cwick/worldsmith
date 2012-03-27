require 'spec_helper'

module WorldSmith
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

      subject.find(:die).name.should == "die"
    end

    it "should return nil when there is no matching route" do
      subject.find(:does_not_exist).should be_nil
    end

    it "should create a CommandProxy for routed commands" do
      class MockCommandProxy; end
      proxy = MockCommandProxy.new
      proxy.should_receive(:call)

      CommandProxy.stub(:new).and_return(proxy)

      subject.draw do
        command :quit
      end

      subject.find(:quit).call
    end
  end
end
