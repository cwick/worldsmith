require 'spec_helper'

module WorldSmith
  describe Room do
    let(:room) { subject }

    describe "#add_exit" do
      it "links to Limbo by default" do
        room.add_exit(:south)
        room.through_exit(:south).should == Room::Limbo
      end

      it "raises an exception if the exit already exists" do
        room.add_exit(:south)
        lambda { room.add_exit(:south) }.should raise_error(ArgumentError)
      end

      it "can connect two rooms together" do
        other_room = Room.new
        room.add_exit(:north, other_room)
        room.through_exit(:north).should == other_room
      end

      it "does not add an implicit link back to the original room" do
        other_room = Room.new
        room.add_exit(:one_way, other_room)
        other_room.should_not have_exit(:one_way)
      end

      it "can link a room to itself" do
        room.add_exit(:strange, room)
        room.through_exit(:strange).should == room
      end
    end

    describe "#through_exit" do
      it "raises an exception if the exit does not exist" do
        lambda { room.through_exit(:notfound) }.should raise_error(NoExitError)
      end
    end

    describe "#has_exit?" do
      it "returns true when there is an exit" do
        room.add_exit(:up)
        room.should have_exit(:up)
      end

      it "returns false when there is not an exit" do
        room.should_not have_exit(:notfound)
      end
    end

    it "can contain objects"
    it "can be persisted to a database"
    it "can be restored from a database"
  end
end

