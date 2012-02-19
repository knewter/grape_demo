RSpec.configure do |config|
  config.before(:each) do
    Mongoid::IdentityMap.clear
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
  config.after(:all) do
    Mongoid.master.command({'dropDatabase' => 1})
  end
end

