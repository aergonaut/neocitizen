# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'neocitizen/version'

Gem::Specification.new do |spec|
  spec.name          = "neocitizen"
  spec.version       = Neocitizen::VERSION
  spec.authors       = ["Chris Fung"]
  spec.email         = ["aergonaut@gmail.com"]
  spec.summary       = "Toolkit for creating sites on neocities.org"
  spec.homepage      = "https://github.com/aergonaut/neocitizen"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "rspec"

  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "faraday", "~> 0.9"
  spec.add_dependency "excon", "~> 0.34"
  spec.add_dependency "mimemagic", "~> 0.2"
  spec.add_dependency "multi_json", "~> 1.10"
  spec.add_dependency "json_pure", "~> 1.8"
end
