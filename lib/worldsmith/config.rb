module WorldSmith
  module Config
    attr_writer :root

    def root
      @root or raise WorldSmith::ConfigurationError.new(
        "Project root has not been configured yet.")
    end
  end
end

