# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_agnostic_models/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_agnostic_models"
  spec.version       = RailsAgnosticModels::VERSION
  spec.authors       = ["DVG"]
  spec.email         = ["devryguy@gmail.com"]
  spec.description   = %q{The purpose of this project is to ease the pain of upgrading Rails versions by abstracting away differences between the Rails 2.3 and 3.2 API.}
  spec.summary       = %q{Extends activerecord to provide rails-agnostic versions of common model code to east the pain of upgrading}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "debugger"
end
