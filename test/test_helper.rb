# Test helper, should be required by all tests. Note that requiring 'test/unit'
# first is needed to make test autorun work (I'm not sure why).

# TODO Most of the below should be extracted into code shared with the
# equivalent helper in the spec directory (spec_helper.rb).
require 'pathname'
__DIR__ = Pathname.new(__FILE__).dirname
$LOAD_PATH.unshift __DIR__
$LOAD_PATH.unshift __DIR__ + '../lib'

require 'active_record'
driver = ENV["DB"] || 'sqlite3'
database_config = YAML::load(File.open(__DIR__ + "../spec/support/database.#{driver}.yml"))
ActiveRecord::Base.establish_connection(database_config)

require 'active_record_ignored_attributes'

# Requires supporting ruby files in spec/support/
Dir[__DIR__ + '../spec/support/**/*.rb'].each do |f|
  require f
end

require 'test/unit'
require 'active_support/test_case'
