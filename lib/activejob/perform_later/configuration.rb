module Activejob
  module PerformLater
    class Configuration
      attr_accessor :job_base_class # ActiveJob::Base

      def initialize
        if defined?(ApplicationJob)
          @job_base_class = ApplicationJob
        else
          @job_base_class = ActiveJob::Base
        end
      end
    end
  end
end
