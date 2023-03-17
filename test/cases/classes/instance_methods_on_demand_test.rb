require "helper"
require "support/test_class"

class ClassesInstanceMethodsOnDemandTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  def test_enqueues_the_job
    assert_enqueued_jobs 1 do
      TestClass.new.perform_later.six
    end
  end

  def test_enqueues_the_job_with_arguments
    assert_enqueued_with(job: Activejob::PerformLater::Job, args: [TestClass.new, "six", [1, 2], {}]) do
      TestClass.new.perform_later.six(1, 2)
    end
  end

  def test_enqueues_the_job_with_delay
    travel_to Time.now do
      assert_enqueued_with(job: Activejob::PerformLater::Job, at: 60.seconds.from_now.to_f) do
        TestClass.new.perform_later(wait: 60.seconds).six
      end
    end
  end

  def test_enqueues_the_job_on_a_queue
    assert_enqueued_with(job: Activejob::PerformLater::Job, queue: "non_default") do
      TestClass.new.perform_later(queue: "non_default").six
    end
  end

  def test_performs_the_job
    assert_performed_jobs 1 do
      TestClass.new.perform_later.six
    end
  end

  def test_performs_the_job_with_arguments
    assert_performed_with(job: Activejob::PerformLater::Job, args: [TestClass.new, "six", [1, 2], {}]) do
      TestClass.new.perform_later.six(1, 2)
    end
  end

  def test_performs_the_job_with_delay
    travel_to Time.now do
      assert_performed_with(job: Activejob::PerformLater::Job, at: 60.seconds.from_now.to_f) do
        TestClass.new.perform_later(wait: 60.seconds).six
      end
    end
  end

  def test_performs_the_job_on_a_queue
    assert_performed_with(job: Activejob::PerformLater::Job, queue: "non_default") do
      TestClass.new.perform_later(queue: "non_default").six
    end
  end
end
