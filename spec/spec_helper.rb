require 'yaml'
require 'byebug'

__DIR__ = Pathname.new(__FILE__).dirname
$LOAD_PATH.unshift __DIR__
$LOAD_PATH.unshift __DIR__ + '../lib'

#---------------------------------------------------------------------------------------------------
# ActiveRecord

require 'active_record'
driver = ENV["DB"] || 'sqlite3'
#require driver
database_config = YAML::load(File.open(__DIR__ + "support/database.#{driver}.yml"))
ActiveRecord::Base.establish_connection(database_config)

#---------------------------------------------------------------------------------------------------
# RSpec

require 'rspec'

RSpec.configure do |config|
  config.mock_with :rr
end

require 'active_record_ignored_attributes'
require 'active_record_ignored_attributes/matchers'

# Requires supporting ruby files in spec/support/
Dir[__DIR__ + 'support/**/*.rb'].each do |f|
  require f
end
