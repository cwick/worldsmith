require 'rspec'
require 'spec_helper'

WorldSmith::CommandRouter.routes.draw do
  command :south
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

