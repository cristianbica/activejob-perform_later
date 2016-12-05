require "activejob/perform_later/version"
require "active_support"
require "active_job"

module Activejob
  module PerformLater
    extend ActiveSupport::Autoload

    autoload :Job
    autoload :Proxy
    autoload :Mixin
    autoload :Util
  end
end

Object.send(:include, Activejob::PerformLater::Mixin)
Object.send(:extend, Activejob::PerformLater::Mixin)
Module.send(:extend, Activejob::PerformLater::Mixin)
