require 'spec_helper'

module WorldSmith
  describe Command do
    it "keeps track of the current player" do
      player = Object.new
      subject.current_player = player
      subject.current_player.should == player
    end
  end
end


