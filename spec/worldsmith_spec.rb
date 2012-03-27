require 'spec_helper'

module WorldSmith
  describe "#root" do
    it "should keep track of the project's root directory" do
      WorldSmith.root = "foo"
      WorldSmith.root.should == "foo"
    end

    it "should raise an exception if the project root hasn't
        been configured yet" do
      lambda { WorldSmith.root }.should raise_error(ConfigurationError)
    end
  end
end
