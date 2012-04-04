class SouthCommand < WorldSmith::Command
  def call
    here = current_player.location
    current_player.location = here.through_exit(:south)
  end
end

