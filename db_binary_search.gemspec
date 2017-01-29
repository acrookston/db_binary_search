# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'db_binary_search/version'

Gem::Specification.new do |spec|
  spec.name          = "db_binary_search"
  spec.version       = DBBinarySearch::VERSION
  spec.authors       = ["Andrew Crookston"]
  spec.email         = ["andrew@caoos.com"]

  spec.summary       = %q{An Active Support concern extending Active Record with the ability to binary search a table for use with non-indexed, chronologically sorted tables.}
  spec.description   = %q{
    The gem allows you to avoid slow database scans if you have an
    auto-incrementing primary key running in parallel with a column which
    you want to search.
  }
  spec.homepage      = "http://github.com/acrookston/db_binary_search"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 4.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-mocks"
  spec.add_development_dependency "sqlite3-ruby"
  spec.add_development_dependency "byebug"
end

