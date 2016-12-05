module Activejob
  module PerformLater
    module Mixin
      def perform_later(*method_names)
        options = method_names.extract_options!
        if method_names.empty?
          Activejob::PerformLater::Util.proxy_calls(self, options)
        else
          Activejob::PerformLater::Util.perform_methods_later(self, method_names, options)
        end
      end
    end
  end
end
