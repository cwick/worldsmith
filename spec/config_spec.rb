require 'spec_helper'

module WorldSmith
  describe Config do
    subject do
      Class.new do
        extend Config
      end
    end

    it "should keep track of the project's root directory" do
      subject.root = "foo"
      subject.root.should == "foo"
    end

    it "should raise an exception if the project root hasn't
        been configured yet" do
      lambda { subject.root }.should raise_error(ConfigurationError)
    end
  end
end
