require 'spec_helper'

module WorldSmith
  describe Command do
    it "keeps track of the current player" do
      player = Object.new
      command = Command.new(current_player: player)
      command.current_player.should == player
    end
  end
end


