RSpec::Matchers.define :be_in_room do |expected|
  match do |actual|
    actual.location == expected
  end
end

