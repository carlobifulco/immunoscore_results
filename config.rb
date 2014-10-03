# export destination directory for reformatted immunoscore results
EXPORT_DIR= "/Users/carlobifulco/Desktop/fda_amp"

# source immunoscore directory
BASE_DIR= "/Users/carlobifulco/Desktop/fda_amp"
# data base name
DATABASE_NAME= "immunoscore_results_aggregator"

module ShowConfig
  def self.show_config
    puts "PATH: #{File.absolute_path(__FILE__)}"
    File.absolute_path(__FILE__)
    end
end
