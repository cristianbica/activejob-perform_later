require 'bundler'
Bundler.setup

$LOAD_PATH << File.dirname(__FILE__) + '/../lib'

require 'activejob/perform_later'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/numeric/time'

ActiveSupport::TestCase.test_order = :random
ActiveJob::Base.queue_adapter = :test
GlobalID.app = 'ajpl'
ActiveJob::Base.logger.level = Logger::ERROR

require 'active_support/testing/autorun'
