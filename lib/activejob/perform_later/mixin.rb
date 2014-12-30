module Activejob
  module PerformLater
    module Mixin
      extend ActiveSupport::Concern

      module ClassMethods
        def perform_later(*args)
          if args[0].is_a?(Symbol)
            raise ArgumentError, "#{self} does not have a `#{args[0]}` class method" unless respond_to?(args[0])
            method  = args[0]
            options = args[1]||{}

            aliased_method, punctuation = method.to_s.sub(/([?!=])$/, ''), $1
            now_method, later_method = "#{aliased_method}_now#{punctuation}", "#{aliased_method}_later#{punctuation}"

            singleton_class.send(:define_method, later_method) do |*args|
              Job.new(self.name, now_method, args).enqueue options
            end

            singleton_class.send(:alias_method, now_method, method)
            singleton_class.send(:alias_method, method, later_method)
          else
            options = args[0]||{}
            Proxy.new(self.name, options)
          end
        end
      end

      def perform_later(options={})
        Proxy.new(self, options)
      end
    end
  end
end
