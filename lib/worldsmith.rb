Dir[File.dirname(__FILE__) + "/worldsmith/**/*.rb"].each {|f| require f}

module WorldSmith
  extend Config
end
