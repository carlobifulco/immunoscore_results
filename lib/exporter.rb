#Copyright (c) 2014, Carlo B. Bifulco. All rights reserved.


require "csv"
require_relative "analyzer"
require_relative "data_struct"
require_relative "immunoscore_results_loader"

### Where all export from Definiens go
EXPORT_DIR=YAML.load_file("config.yaml")["export_dir"] or "./results_export"

def export_clean_all
  `rm -rf #{EXPORT_DIR}/*`
end

def cd3? file_path
  not (file_path !~ /_CD3_/)
end

def cd8? file_path
  not (file_path !~ /_CD8_/)
end

def export_file case_dir,file_path
  if cd8? file_path
    Dir.mkdir(case_dir+"/CD8")  unless Dir.exist?(case_dir+"/CD8")
    fh=File.new(case_dir+"/CD8/"+File.basename(file_path),"w")
  else
    Dir.mkdir(case_dir+"/CD3")  unless Dir.exist?(case_dir+"/CD3")
    fh=File.new(case_dir+"/CD3/"+File.basename(file_path),"w")
  end

end

# exports novel directory structure with only relevant files
def export_mongo
  # defined in immunoscore_results_loader
  JSON_CLASS_MAPPER.values.each do |mm_class|
    mm_class.all.each do |mm_object|
      puts "#{mm_object}: #{mm_object[:case_n]}"
      next unless mm_object[:case_n] != nil
      case_dir=(EXPORT_DIR+"/"+ mm_object[:case_n]) 
      Dir.mkdir case_dir unless Dir.exist?(case_dir)
      fh=export_file case_dir, mm_object[:path]
      fh.write(mm_object[:data_load])
      fh.close
   
    end
  end
end



def make_html reporting_order=[
                :histogram,
                :original,
                :density,
                :ct_tile,
                :im_tile,
                :statistic,
                :classification]
  all_cases=[]
  ImmunoScoreResults.all.each do |i|
    case_summary=[]
    i.cd.sort.each do |slide_cd|
      reporting_order.each do |feature|
        slide_cd.public_send(feature).sort!{|a,b| a.path<=>b.path}.each do |report|
          #binding.pry
          case_summary<< report[:path]
        end
      end
    end
    all_cases << case_summary
  end
  all_cases
end