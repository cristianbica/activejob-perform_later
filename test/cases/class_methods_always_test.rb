require 'helper'
require 'classes/test_class'

class ClassMethodsAlwaysTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  def test_creates_later_and_now_methods
    assert_respond_to TestClass, :one_later
    assert_respond_to TestClass, :one_now
  end

  def test_creates_later_and_now_methods_with_punctuation
    assert_respond_to TestClass, :four_later?
    assert_respond_to TestClass, :four_now?
  end

  def test_enqueues_the_job
    assert_enqueued_jobs 1 do
      TestClass.one
    end
  end

  def test_enqueues_the_job_with_delay
    travel_to Time.now do
      assert_enqueued_with(job: Activejob::PerformLater::Job, args: ["TestClass", "two_now", [1, 2]], at: 60.seconds.from_now.to_f) do
        TestClass.two(1, 2)
      end
    end
  end

  def test_enqueues_the_job_on_a_queue
    assert_enqueued_with(job: Activejob::PerformLater::Job, args: ["TestClass", "three_now", [1, 2]], queue: 'non_default') do
      TestClass.three(1, 2)
    end
  end

  def test_performs_the_job
    assert_performed_jobs 1 do
      TestClass.one
    end
  end

  def test_performs_the_job_with_delay
    travel_to Time.now do
      assert_performed_with(job: Activejob::PerformLater::Job, args: ["TestClass", "two_now", [1, 2]], at: 60.seconds.from_now.to_f) do
        TestClass.two(1, 2)
      end
    end
  end

  def test_performs_the_job_on_a_queue
    assert_performed_with(job: Activejob::PerformLater::Job, args: ["TestClass", "three_now", [1, 2]], queue: 'non_default') do
      TestClass.three(1, 2)
    end
  end
end
