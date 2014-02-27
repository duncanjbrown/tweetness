require 'yaml'
require 'data_mapper'
require 'database_cleaner'
require 'factory_girl'
require 'faker'

require_relative '../lib/tweet.rb'

RSpec.configure do |config|
  db_config = YAML.load_file('db/config.yml')
  DataMapper::setup(:default, db_config["test"])
  DataMapper.finalize
  Tweet.auto_migrate!
  config.include FactoryGirl::Syntax::Methods

  DatabaseCleaner.strategy = :truncation

  config.before(:each) do
    DatabaseCleaner.clean
  end
end
