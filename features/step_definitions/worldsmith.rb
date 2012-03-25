module TestWorld
  def player
    WorldSmith::Player.new
  end

  def rooms(name)

  end

  def command(name)

  end
end

World(TestWorld)

Given /^I am in the Town Square$/ do
  player.current_room = rooms(:town_square)
end

When /^I move south$/ do
  command :south
end

Then /^I should be in the General Store$/ do
  player.should be_in_room(rooms(:general_store))
end

