module Activejob
  module PerformLater
    class Job < ActiveJob::Base
      include ::Activejob::PerformLater::JobMixin
    end
  end
end
