require 'bundler/gem_tasks'
require 'rake/testtask'

#require 'bundler'
#begin
#  Bundler.setup(:default, :development)
#rescue Bundler::BundlerError => e
#  $stderr.puts e.message
#  $stderr.puts "Run `bundle install` to install missing gems"
#  exit e.status_code
#end

#---------------------------------------------------------------------------------------------------
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*test.rb']
  t.verbose = true
end

task :default => :spec
