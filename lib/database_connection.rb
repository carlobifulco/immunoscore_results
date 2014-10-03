require "yaml"
require "mongo_mapper"
### Specify Database name; dynamic based on dir location in path
if File.exists?("./config.yaml") 
  DATABASE_NAME= (YAML.load_file("./config.yaml")["database_name"]) 
elsif File.exists?("../config.yaml") 
  DATABASE_NAME= (YAML.load_file("../config.yaml")["database_name"]) 
else
  DATABASE_NAME= (File.basename File.absolute_path ".")
end
MongoMapper.database = DATABASE_NAME
