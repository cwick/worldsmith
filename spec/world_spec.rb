module WorldSmith
  describe World do
    before do
      WorldSmith.root = '/myproject'
    end

    let(:simple_world) do
      world = World.new
      world.add_room(Room.new)
      world.add_room(Room.new)
      world
    end

    let(:world_with_cycles) do
      world = World.new
      room1 = Room.new
      room2 = Room.new
      room1.add_exit(:up, room2)
      room2.add_exit(:down, room1)

      world.add_room(room1)
      world.add_room(room2)
      world
    end

    describe "#save" do
      it "saves to db/world.yml by default" do
        File.should_receive(:open)
          .with(File.join(WorldSmith.root, 'db', 'world.yml'), 'w')
        subject.save
      end

      it "saves a simple world" do
        File.open('spec/data/world_example.yml') do |stream|
          expected_output = stream.read
          output = StringIO.new

          simple_world.save(output)
          output.string.should == expected_output
        end
      end

      it "saves a world with cycles" do
        File.open('spec/data/world_with_cycles_example.yml') do |stream|
          expected_output = stream.read
          output = StringIO.new

          world_with_cycles.save(output)
          output.string.should == expected_output
        end
      end
    end

    it "stores a list of rooms" do
      rooms = [Room.new, Room.new]
      rooms.each { |room| subject.add_room(room) }
      rooms.each { |room| subject.rooms.should include(room) }
    end

    describe "#load" do
      it "reads from db/world.yml by default" do
        File.should_receive(:open)
          .with(File.join(WorldSmith.root, 'db', 'world.yml'), 'r')
          .and_return(StringIO.new)
        World.load
      end

      it "restores a simple world" do
        File.open('spec/data/world_example.yml') do |world_data|
          subject.add_room(Room.new)
          subject.add_room(Room.new)
          world = World.load(world_data)
          world.rooms.should == subject.rooms
        end
      end

      it "restores a world with cycles" do
        File.open('spec/data/world_with_cycles_example.yml') do |world_data|
          world = World.load(world_data)
          room1 = world.find_room_by_id(1)
          room2 = world.find_room_by_id(2)

          room1.through_exit(:up).should == room2
          room2.through_exit(:down).should == room1
        end
      end
    end

    it "Assigns unique IDs to each room" do
      room1 = Room.new
      room2 = Room.new
      subject.add_room(room1)
      subject.add_room(room2)

      room1.id.should_not == room2.id
    end

    describe "#find_room_by_id" do
      it "Can find rooms by ID" do
        room1 = Room.new
        room2 = Room.new

        room1.id = 123
        room2.id = 456

        subject.add_room(room1)
        subject.add_room(room2)

        subject.find_room_by_id(123).should == room1
        subject.find_room_by_id(456).should == room2
      end

      it "throws an exception if the room can't be found" do
        lambda { subject.find_room_by_id(999) }.should raise_error(RoomNotFoundError)
      end
    end
  end
end
