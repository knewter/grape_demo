require 'rspec'
require 'capybara/rspec'
require 'rack'

# use the rackup file to load the apps w/their respective URL mappings, sweet!
Capybara.app = eval "Rack::Builder.new {( " + File.read(File.dirname(__FILE__) + '/../../config.ru') + "\n )}"

class Spinach::FeatureSteps
  include Capybara::DSL
end

Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app)
end
