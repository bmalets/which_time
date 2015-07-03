# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'which_time/version'

Gem::Specification.new do |spec|
  spec.name          = "which_time"
  spec.version       = WhichTime::VERSION
  spec.authors       = ["bmalets"]
  spec.email         = ["b.malets@gmail.com"]
  spec.summary       = %q{ search local time by your location }
  spec.description   = %q{ this gem provides a possibility to search local time by street/place_name/city/region/country e.g. }
  spec.homepage      = "https://github.com/bmalets/which_time"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
