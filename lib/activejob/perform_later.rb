require "activejob/perform_later/version"
require 'active_support'
require 'active_job'

module Activejob
  module PerformLater
    extend ActiveSupport::Autoload

    autoload :Job
    autoload :Proxy
    autoload :Mixin
  end
end

Object.send(:include, Activejob::PerformLater::Mixin)
