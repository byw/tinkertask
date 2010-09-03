require "#{RAILS_ROOT}/lib/logger_format"

db_config = YAML::load(File.read(RAILS_ROOT + "/config/database.yml"))

if db_config[Rails.env] && db_config[Rails.env]['adapter'] == 'mongodb'
  mongo = db_config[Rails.env]
  
  MongoMapper.connection = Mongo::Connection.new(mongo['host'], mongo['port'], :logger => Rails.logger)
  MongoMapper.database = mongo['database']
  MongoMapper.database.authenticate(mongo['username'], mongo['password'])
  
  MongoMapper.connection.connect_to_master
  
end

#identity map plugin for mongomapper
module IdentityMapAddition
  def self.included(model)
    model.plugin MongoMapper::Plugins::IdentityMap
  end
end

MongoMapper::Document.append_inclusions(IdentityMapAddition)
