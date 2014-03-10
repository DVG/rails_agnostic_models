require 'active_record'
require 'yaml'
require 'database_cleaner'
require 'debugger'

database_yml = File.expand_path('../../spec/database.yml', __FILE__)

if File.exists?(database_yml)
  active_record_configuration = YAML.load_file(database_yml)

  ActiveRecord::Base.configurations = active_record_configuration
  config = ActiveRecord::Base.configurations['sqlite3']
  ActiveRecord::Base.establish_connection(config)
else
  raise "Please create #{database_yml} first to configure your database. Take a look at: #{database_yml}.sample"
end

require 'rails_agnostic_models'
Dir["spec/support/**/*.rb"].each { |f| require File.expand_path(f) }

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end
  config.after :each do 
    DatabaseCleaner.clean 
  end
end
