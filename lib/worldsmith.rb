Dir[File.dirname(__FILE__) + "/worldsmith/**/*.rb"].select do |f|
  !f.match 'worldsmith/cli'
end.each {|f| require f}

module WorldSmith
  extend Config
end
