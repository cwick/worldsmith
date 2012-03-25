require_relative '../lib/worldsmith.rb'

module CustomSmithMatchers
  class BeInRoom
    def initialize(expected)
      @expected = expected
    end

    def matches?(target)
      @target = target
      @target.current_room.eql?(@expected)
    end

    def failure_message
      "expected #{@target.inspect} to be in Room #{@expected}"
    end

    def negative_failure_message
      "expected #{@target.inspect} not to be in Room #{@expected}"
    end
  end

  def be_in_room(expected)
    BeInRoom.new(expected)
  end
end

RSpec.configure do |config|
  config.include(CustomSmithMatchers)
end
