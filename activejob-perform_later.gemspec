# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activejob/perform_later/version'

Gem::Specification.new do |spec|
  spec.name          = "activejob-perform_later"
  spec.version       = Activejob::PerformLater::VERSION
  spec.authors       = ["Cristian Bica"]
  spec.email         = ["cristian.bica@gmail.com"]
  spec.summary       = %q{Make any method perfomed later.}
  spec.description   = %q{Take advantage of Active Job you can perform any class method later.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activejob'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
