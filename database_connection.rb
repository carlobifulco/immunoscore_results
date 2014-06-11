### Specify Database name; dynamic based on dir
DATABASE_NAME= (YAML.load_file("./config.yaml")["database_name"] or (File.basename File.absolute_path "."))
MongoMapper.database = DATABASE_NAME
