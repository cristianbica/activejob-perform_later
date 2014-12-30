# Activejob::PerformLater

Make any method perfomed later.

## Installation

Add this line to your application's Gemfile:

    gem 'activejob-perform_later'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activejob-perform_later

## Usage

### Declare your class methods as always performed later

```ruby
class MyClass
  def self.a_method(arg1, arg2)
    # do stuff
  end
  perform_later :a_method
  perform_later :a_method, queue: :low_priority
  perform_later :a_method, wait: 10.minutes
  perform_later :a_method, wait: 60.minutes, queue: :low_priority
end

#calling the method will actually schedule the method to be performed later by ActiveJob
MyClass.a_method(1, 2)
```

### Perform your class method delayed whenever you need that

```ruby
class MyClass
  def self.a_method(arg1, arg2)
    # do stuff
  end
end

# calling the method directly will perform it inline
MyClass.a_method(1,2)

# calling the method with perform_later will schedule the performing in Active Job
MyClass.perform_later.a_method(1,2)
MyClass.perform_later(queue: :low_priority).a_method(1,2)
MyClass.perform_later(wait: 10.minutes).a_method(1,2)
MyClass.perform_later(wait: 10.minutes, queue: :low_priority).a_method(1,2)
MyClass.perform_later(wait_until: 60.minutes.from_now, queue: :low_priority).a_method(1,2)
end
```

### Perform your instance method delayed

This works only if your class is safe to be passed to Active Job (e.g.: it's global
identificable with GlobalID. Active Record implements GlobalID since 4.2.0):

```ruby
class User < ActiveRecord::Base
  def recalculate_billing
    # do stuff
  end
end

# calling the method with perform_later will schedule the performing in Active Job
User.last.perform_later.recalculate_billing
User.last.perform_later(queue: :low_priority).recalculate_billing
User.last.perform_later(wait: 10.minutes).recalculate_billing
User.last.perform_later(wait_until: 60.minutes.from_now).recalculate_billing
User.last.perform_later(wait: 10.minutes, queue: :low_priority).recalculate_billing
User.last.perform_later(wait_until: 60.minutes.from_now, queue: :low_priority).recalculate_billing
end
```

## Contributing

1. Fork it ( https://github.com/cristianbica/activejob-perform_later/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
