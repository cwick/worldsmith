require 'rspec'
require 'spec_helper'

WorldSmith::CommandRouter.routes.draw do
  command :south
end

Before do
  WorldSmith.root = File.absolute_path(File.join(File.dirname(__FILE__), "../../"))
end

module TestWorld
  def initialize
    @wtf = {}
  end

  def player
    @player ||= WorldSmith::Player.new
  end

  def world
    @world ||= WorldSmith::World.load
  end

  def rooms(name)
    # TODO: support tags on rooms so we don't have to manually translate
    case name
    when :town_square
      id = 1
    when :general_store
      id = 2
    end
    world.find_room_by_id(id)
  end

  def command(name)
    handler = WorldSmith::CommandRouter.route(name)
    handler.env = { current_player: player }
    handler.call
  end
end

World(TestWorld)

