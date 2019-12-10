require "helper"
require "support/test_class"

class ClassesInstanceMethodsOnDemandTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  def global_id(obj)
    {"_aj_globalid" => obj.to_global_id.to_s}
  end

  def test_enqueues_the_job
    assert_enqueued_jobs 1 do
      TestClass.new.perform_later.six
    end
  end

  def test_enqueues_the_job_with_arguments
    test_instance = TestClass.new

    assert_enqueued_jobs 1 do
      test_instance.perform_later.six(1, 2)

      expected_job_params =  {
        :job=>Activejob::PerformLater::Job,
        :args=>[global_id(test_instance), "six", [1, 2]],
        :queue=>"default"
      }

      assert_equal(enqueued_jobs, [expected_job_params])
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
    test_instance = TestClass.new

    assert_performed_jobs 1 do
      test_instance.perform_later.six(1, 2)

      expected_job_params =  {
        :job=>Activejob::PerformLater::Job,
        :args=>[global_id(test_instance), "six", [1, 2]],
        :queue=>"default"
      }

      assert_equal(performed_jobs, [expected_job_params])
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
