require 'spec_helper'

module WorldSmith
  describe Player do
    context "freshly spawned" do
      it "should be in limbo" do
        subject.current_room.should == Room::Limbo
      end

      it "can be placed in a room" do
        room = Object.new
        subject.current_room = room
        subject.should be_in_room(room)
      end
    end
  end
end
