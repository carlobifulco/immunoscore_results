# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'immunoscore_results_aggregator/version'

Gem::Specification.new do |s|
  s.name        = 'immunoscore_results_aggregator'
  s.version     = '0.0.1'
  s.date        = '2014-10-01'
  s.add_runtime_dependency "bson_ext"
  s.add_runtime_dependency 'mongo_mapper'
  s.add_runtime_dependency "bson_ext"
  s.add_runtime_dependency 'gibberish'
  s.add_runtime_dependency 'bicrypt'
  s.add_runtime_dependency 'chronic'
  s.add_runtime_dependency "thor"
  s.add_runtime_dependency 'mm-versionable'
  s.summary     = "immunoscore_results_aggregator"
  s.description = "immunoscore_results_aggregator"
  s.license       = "MIT"
  s.authors     = ["Carlo Bifulco"]
  s.email       = 'carlobif@gmail.com'
  s.files       = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.homepage    =
    'https://github.com/carlobifulco/immunoscore_results'
  s.require_paths = ["lib"]
  s.license       = 'MIT'
  s.add_development_dependency "bundler", "~> 1.6"
  s.add_development_dependency "rake"
end

