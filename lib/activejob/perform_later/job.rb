module Activejob
  module PerformLater
    class Job < ActiveJob::Base
      def perform(target, method_name, args, opts)
        target = target.safe_constantize if target.is_a?(String)
        target.public_send method_name, *args, **opts
      end
    end
  end
end
