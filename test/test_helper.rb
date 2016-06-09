ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'factory_girl'

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end

end
