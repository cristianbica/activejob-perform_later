module Activejob
  module PerformLater
    module Util
      extend self

      def proxy_calls(obj, options)
        Proxy.new(obj, options)
      end

      def perform_methods_later(obj, method_names, options)
        raise ArgumentError, "You can only declare class methods as delayed" unless obj.class == Class || obj.class == Module
        method_names.each do |method_name|
          perform_method_later(obj, method_name, options)
        end
      end

      def perform_method_later(obj, method_name, options)
        raise ArgumentError, "#{self} must respond to `#{method_name}`" unless obj.respond_to?(method_name)
        aliased_method, punctuation = method_name.to_s.sub(/([?!=])$/, ""), $1
        now_method, later_method = "#{aliased_method}_now#{punctuation}", "#{aliased_method}_later#{punctuation}"
        obj.singleton_class.send(:define_method, later_method) do |*args|
          ::Activejob::PerformLater.configuration.job_class.new(::Activejob::PerformLater::Util.proxiable_object(obj), now_method, args).enqueue options
        end
        obj.singleton_class.send(:alias_method, now_method, method_name)
        obj.singleton_class.send(:alias_method, method_name, later_method)
      end

      def proxiable_object(obj)
        obj.class == ::Class || obj.class == ::Module ? obj.name : obj
      end
    end
  end
end
