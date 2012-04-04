require 'rspec'
require 'spec_helper'

WorldSmith::CommandRouter.routes.draw do
  command :south
end

Before do
  WorldSmith.root = File.absolute_path(File.join(File.dirname(__FILE__), "../../"))
end

module TestWorld
  @@rooms = {}

  # TODO move this into the database layer
  @@rooms[:town_square] = WorldSmith::Room.new
  @@rooms[:general_store] = WorldSmith::Room.new

  @@rooms[:town_square].add_exit(:south, @@rooms[:general_store])

  def initialize
    @wtf = {}
  end

  def player
    WorldSmith::Player.new
  end

  def rooms(name)
    @@rooms[name]
  end

  def command(name)
    handler = WorldSmith::CommandRouter.route(name)
    handler.call
  end
end

World(TestWorld)

