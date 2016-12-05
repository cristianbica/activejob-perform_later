require "helper"
require "support/test_module"

class ModulesAlwaysTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  def test_creates_later_and_now_methods
    assert_respond_to TestModule, :one_later
    assert_respond_to TestModule, :one_now
  end

  def test_creates_later_and_now_methods_with_punctuation
    assert_respond_to TestModule, :four_later?
    assert_respond_to TestModule, :four_now?
  end

  def test_enqueues_the_job
    assert_enqueued_jobs 1 do
      TestModule.one
    end
  end

  def test_enqueues_the_job_with_delay
    travel_to Time.now do
      assert_enqueued_with(job: Activejob::PerformLater::Job, args: ["TestModule", "two_now", [1, 2]], at: 60.seconds.from_now.to_f) do
        TestModule.two(1, 2)
      end
    end
  end

  def test_enqueues_the_job_on_a_queue
    assert_enqueued_with(job: Activejob::PerformLater::Job, args: ["TestModule", "three_now", [1, 2]], queue: "non_default") do
      TestModule.three(1, 2)
    end
  end

  def test_performs_the_job
    assert_performed_jobs 1 do
      TestModule.one
    end
  end

  def test_performs_the_job_with_delay
    travel_to Time.now do
      assert_performed_with(job: Activejob::PerformLater::Job, args: ["TestModule", "two_now", [1, 2]], at: 60.seconds.from_now.to_f) do
        TestModule.two(1, 2)
      end
    end
  end

  def test_performs_the_job_on_a_queue
    assert_performed_with(job: Activejob::PerformLater::Job, args: ["TestModule", "three_now", [1, 2]], queue: "non_default") do
      TestModule.three(1, 2)
    end
  end
end
