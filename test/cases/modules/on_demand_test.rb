require "helper"
require "support/test_module"

class ModulesOnDemandTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  def test_enqueues_the_job
    assert_enqueued_jobs 1 do
      TestModule.perform_later.five
    end
  end

  def test_enqueues_the_job_with_arguments
    assert_enqueued_with(job: Activejob::PerformLater::Job, args: ["TestModule", "five", [1, 2], {}]) do
      TestModule.perform_later.five(1, 2)
    end
  end

  def test_enqueues_the_job_with_delay
    travel_to Time.now do
      assert_enqueued_with(job: Activejob::PerformLater::Job, args: ["TestModule", "five", [1, 2], {}], at: 60.seconds.from_now.to_f) do
        TestModule.perform_later(wait: 60.seconds).five(1, 2)
      end
    end
  end

  def test_enqueues_the_job_on_a_queue
    assert_enqueued_with(job: Activejob::PerformLater::Job, args: ["TestModule", "five", [1, 2], {}], queue: "non_default") do
      TestModule.perform_later(queue: "non_default").five(1, 2)
    end
  end

  def test_performs_the_job
    assert_performed_jobs 1 do
      TestModule.perform_later.five
    end
  end

  def test_performs_the_job_with_arguments
    assert_performed_with(job: Activejob::PerformLater::Job, args: ["TestModule", "five", [1, 2], {}]) do
      TestModule.perform_later.five(1, 2)
    end
  end

  def test_performs_the_job_with_delay
    travel_to Time.now do
      assert_performed_with(job: Activejob::PerformLater::Job, args: ["TestModule", "five", [1, 2], {}], at: 60.seconds.from_now.to_f) do
        TestModule.perform_later(wait: 60.seconds).five(1, 2)
      end
    end
  end

  def test_performs_the_job_on_a_queue
    assert_performed_with(job: Activejob::PerformLater::Job, args: ["TestModule", "five", [1, 2], {}], queue: "non_default") do
      TestModule.perform_later(queue: "non_default").five(1, 2)
    end
  end
end
