# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sfn_policy/helpers/version'

Gem::Specification.new do |spec|
  spec.name          = "sfn_policy-helpers"
  spec.version       = SfnPolicy::Helpers::VERSION
  spec.authors       = ["Jonathan Serafini"]
  spec.email         = ["jonathan@lightspeedpos.com"]
  spec.summary       = %q{SparkleFormation policy objects}
  spec.description   = %q{Provides syntax helpers for SparkleFormation.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sparkle_formation", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
