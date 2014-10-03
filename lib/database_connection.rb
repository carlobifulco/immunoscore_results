require "yaml"
require "mongo_mapper"
require_relative "../config.rb"
MongoMapper.database = DATABASE_NAME
