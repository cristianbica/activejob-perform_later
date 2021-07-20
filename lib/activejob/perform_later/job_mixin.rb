module Activejob
  module PerformLater
    module JobMixin
      def perform(target, method_name, args)
        target = target.safe_constantize if target.is_a?(String)
        target.public_send method_name, *args
      end
    end
  end
end
