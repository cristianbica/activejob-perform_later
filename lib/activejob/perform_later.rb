require "activejob/perform_later/version"
require "active_support"
require "active_job"
require "activejob/perform_later/configuration"

module Activejob
  module PerformLater
    extend ActiveSupport::Autoload

    autoload :Job
    autoload :Proxy
    autoload :Mixin
    autoload :Util

    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.reset
      @configuration = Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end

Object.send(:include, Activejob::PerformLater::Mixin)
Object.send(:extend, Activejob::PerformLater::Mixin)
Module.send(:extend, Activejob::PerformLater::Mixin)
