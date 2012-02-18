Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("wines")
end
