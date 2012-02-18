require File.expand_path('../boot', __FILE__)
 
Bundler.require :default, ENV['RACK_ENV']
 
# Load any initializers
Dir["#{File.dirname(__FILE__)}/initializers/**/*.rb"].each { |f| require f }

require File.expand_path('../../api/api', __FILE__)
