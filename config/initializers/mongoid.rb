Mongoid.configure do |config|
  base_name = "wines"
  env = ENV['RACK_ENV'] || 'development'
  db_name = [base_name, env].join('_')
  config.master = Mongo::Connection.new.db(db_name)
end
