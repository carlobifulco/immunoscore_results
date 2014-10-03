# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'immunoscore_results_aggregator/version'

Gem::Specification.new do |s|
  s.name        = 'immunoscore_results_aggregator'
  s.version     = '0.0.1'
  s.date        = '2014-10-01'
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

