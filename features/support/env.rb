require 'rspec'
require 'spec_helper'

WorldSmith::CommandRouter.routes.draw do
  command :south
end

Before do
  WorldSmith.root = File.absolute_path(File.join(File.dirname(__FILE__), "../../"))
end

module TestWorld
  def player
    WorldSmith::Player.new
  end

  def rooms(name)

  end

  def command(name)
    handler = WorldSmith::CommandRouter.route(name)
    handler.call
  end
end

World(TestWorld)

