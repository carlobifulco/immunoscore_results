# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


require "immunoscore_results_loader"
require "mongo_aggregator"
require "exporter"