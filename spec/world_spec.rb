module WorldSmith
  describe World do
    before do
      WorldSmith.root = '/myproject'
    end

    describe "#save" do
      it "saves to db/world.yml by default" do
        File.should_receive(:open)
          .with(File.join(WorldSmith.root, 'db', 'world.yml'), 'w')
        subject.save
      end

      it "saves its contents" do
        File.open('spec/data/world_example.yml') do |stream|
          expected_output = stream.read
          output = StringIO.new

          subject.add_room(Room.new)
          subject.add_room(Room.new)
          subject.save(output)
          output.string.should == expected_output
        end
      end
    end

    it "stores a list of rooms" do
      rooms = [Room.new, Room.new]
      rooms.each { |room| subject.add_room(room) }
      subject.rooms.should == rooms
    end

    describe "#load" do
      it "reads from db/world.yml by default" do
        File.should_receive(:open)
          .with(File.join(WorldSmith.root, 'db', 'world.yml'), 'r')
          .and_return(StringIO.new)
        World.load
      end

      it "restores the world" do
        File.open('spec/data/world_example.yml') do |world_data|
          subject.add_room(Room.new)
          subject.add_room(Room.new)
          world = World.load(world_data)
          world.rooms.should == subject.rooms
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
  end
end
