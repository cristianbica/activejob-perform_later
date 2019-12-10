module Activejob
  module PerformLater
    class Configuration
      attr_accessor :job_base_class

      def initialize
        @job_base_class = ActiveJob::Base
      end
    end
  end
end
