RSpec::Matchers.define :be_in_room do |expected|
  match do |actual|
    actual.current_room == expected
  end
end

