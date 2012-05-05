# Command-line interface

ARGV << '--help' if ARGV.empty?

aliases = {
  "s"  => "server",
}

command = ARGV.shift
command = aliases[command] || command

case command
when 'server'
  require_relative 'cli/server'
#
# when '--version', '-v'
#   ARGV.unshift '--version'
#   require 'rails/commands/application'
#
else
  puts "Error: Command not recognized" unless %w(-h --help).include?(command)
  puts <<-EOT
Usage: worldsmith COMMAND [ARGS]

The most common worldsmith commands are:
 server      Start the Rails server (short-cut alias: "s")

All commands can be run with -h for more information.
  EOT
end

