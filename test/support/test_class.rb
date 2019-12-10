class TestClass
  include GlobalID::Identification

  attr_reader :id

  def self.find(id)
    new(id)
  end

  def initialize(id = nil)
    @id = id || SecureRandom.hex
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
