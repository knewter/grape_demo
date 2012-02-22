require File.expand_path('../boot', __FILE__)
 
env = ENV['RACK_ENV'] || 'development'
Bundler.require :default, env
 
# Load any initializers
Dir["#{File.dirname(__FILE__)}/initializers/**/*.rb"].each { |f| require f }

require File.expand_path('../../app/acme_app.rb', __FILE__)
require File.expand_path('../../api/api', __FILE__)

