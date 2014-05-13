require_relative "analyzer"
require_relative "data_struct"
require_relative "immunoscore_results_loader"

clean_all
mongo_load_all(search_all)


###Stat Results will contain all datasets in an csv format
Statistic.all.each do |stat_entry|
  csv_to_mongo stat_entry[:path], StatResults
end

