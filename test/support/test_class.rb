class TestClass
  include GlobalID::Identification

  def self.find(*)
    new
  end

  def id
    0
  end

  def self.one(*)
  end
  perform_later :one

  def self.two(*)
  end
  perform_later :two, wait: 60

  def self.three(*)
  end
  perform_later :three, queue: "non_default"

  def self.four?(*)
  end
  perform_later :four?

  def self.five(*)
  end

  def six(*)
  end
end
