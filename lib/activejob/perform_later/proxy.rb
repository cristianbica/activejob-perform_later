module Activejob
  module PerformLater
    class Proxy < BasicObject
      def initialize(target, options)
        @target = Util.proxiable_object(target)
        @options = options
      end

      def method_missing(method_name, *args)
        ::Activejob::PerformLater.configuration.job_class.new(@target, method_name.to_s, args).enqueue @options
      end
    end
  end
end
