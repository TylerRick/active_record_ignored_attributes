# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "active_record_ignored_attributes/version"

Gem::Specification.new do |s|
  s.name        = "active_record_ignored_attributes"
  s.version     = ActiveRecordIgnoredAttributes.version
  s.authors     = ["Tyler Rick"]
  s.email       = ["tyler@tylerrick.com"]
  s.homepage    = ""
  s.summary     = %q{Allows you to compare Active Record objects based on their *attributes* (with same_as?), to exclude some attributes from being used in comparison, and adds improved inspect method}
  s.description = s.summary

  s.add_dependency             'activerecord', '~> 4'
  s.add_dependency             'facets'

  s.add_development_dependency 'rspec', '~> 3'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'mysql2', '~>0.2.11'
  s.add_development_dependency 'rr'
  s.add_development_dependency 'activesupport', '~> 4'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
