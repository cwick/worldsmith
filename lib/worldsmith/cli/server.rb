require 'eventmachine'

EM.run do
  EM.add_timer(1) { EM.stop }
end
