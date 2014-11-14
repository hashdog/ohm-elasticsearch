# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ohm/elasticsearch/version'

Gem::Specification.new do |spec|
  spec.name          = "ohm-elasticsearch"
  spec.version       = Ohm::Elasticsearch::VERSION
  spec.authors       = ["chebyte", "lguardiola"]
  spec.email         = ["mauro@hashdog.com", "lguardiola@gmail.com"]
  spec.summary       = %q{Very small ruby implementation for Elasticsearch and OHM.}
  spec.description   = %q{Very small ruby implementation for Elasticsearch (https://github.com/elasticsearch) and OHM (https://github.com/soveran/ohm).}
  spec.homepage      = "http://hashdog.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_runtime_dependency 'elasticsearch', '~> 1.0', '>= 1.0.5'
end
