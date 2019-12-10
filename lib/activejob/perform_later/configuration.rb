module Activejob
  module PerformLater
    class Configuration
      attr_accessor :job_base_class

      def initialize
        @job_base_class = default_job_base_class
      end

      def default_job_base_class
        if defined?(ApplicationJob)
          ApplicationJob
        else
          ActiveJob::Base
        end
      end
    end
  end
end
