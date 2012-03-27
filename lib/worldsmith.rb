Dir[File.dirname(__FILE__) + "/worldsmith/**/*.rb"].each {|f| require f}

module WorldSmith
  class << self
    attr_writer :root

    def root
      @root or raise ConfigurationError.new("Project root has not been configured yet.")
    end
  end
end
