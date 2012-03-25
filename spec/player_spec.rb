require 'spec_helper'

module WorldSmith
  describe Player do
    context "freshly spawned" do
      it "should not be in any room" do
        subject.current_room.should be_nil
      end

      it "can be placed in a room" do
        room = Object.new
        subject.current_room = room
        subject.should be_in_room(room)
      end
    end
  end
end
