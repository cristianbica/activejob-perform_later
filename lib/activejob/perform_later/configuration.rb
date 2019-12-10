module Activejob
  module PerformLater
    class Configuration
      attr_accessor :job_class

      def initialize
        @job_class = Activejob::PerformLater::Job
      end
    end
  end
end
