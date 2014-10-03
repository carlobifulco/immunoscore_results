#Copyright (c) 2014, Carlo B. Bifulco. All rights reserved.

require "csv"
require "yaml"
require "mongo_mapper"
require_relative "database_connection"
require_relative "analyzer"
require_relative "data_struct"
require_relative "../config.rb"

#puts "WORKING #{`pwd`}; exists #{File.exists?("../config.yaml")}"


###Pull info from Definiens Immunoscore Directories
# 
# pattern matching based


# filename convetions
# RS_SP02-15779-A8__CD3_2013...
# no underscores in the file name after the RS prefix
# they are required before and after case number for pattern matching

#### A few examples of what we are looking for
#
#image_0000006499_Classification.jpg
#image_0000006504_Original.jpg
#.image_0000006506_densitymap_new.jpg
#.image_0000006506_histogram.jpg
#image_0000006506_CT1.jpg. CT2, CT3
#IM1, IM2, IM3


#BASE_DIR="/Volumes/I\$/Christopher\ Paustian/Colon\ Immunoscore"

### regex utilities
def pull_cd path
  path.match(/.*(CD[8|3]).*/)[1] if path.match(/.*(CD[8|3]).*/)
end

def pull_ct path
  pattern=/.*(CT[1|2|3|4|5|6|7|8])\.jpg/
  path.match(pattern)[1] if path.match(pattern)
end

def pull_im path
  pattern=/.*(IM[1|2|3|4|5|6|7|8])\.jpg/
  path.match(pattern)[1] if path.match(pattern)
end

#### Case identification
# matched file names staring with RS follow by either - or _ followed by SP03
#followed by either - or _ followed by case number.  Matching of teh block
# number is not included 
def get_case_n path
  match=path.match(/(RS[_-].?.?.?.?.[-_]\d*)/i)
  match[0] if match
end


### core function
def find_files file_name_ending="*Classification.jpg", base_dir=BASE_DIR
  results=[]
  Dir.glob("#{base_dir}/**/#{file_name_ending}").each do |full_path|
    puts "am  working on #{full_path}"
    directory_name=full_path.split("\/")[-4]
    case_name=get_case_n full_path
    cd=directory_name.split("_")[2]
    results << {:case_n=>case_name,
                :cd_type =>cd,
                :path=>full_path}
  end
  results
end


#### special functions

def find_ct 
  find_files(file_name_ending="*image*CT*.jpg").map{|x| x[:path]}.map do |path|
    case_n=get_case_n path
    cd =pull_cd(path)
    tile=pull_ct path
    {:cd_type=>cd, :path=>path, :tile=>tile, :case_n=>case_n, :type=>:ct_tile}
  end
end

def find_im
  find_files(file_name_ending="*image*IM*.jpg").map{|x| x[:path]}.map do |path|
    case_n=get_case_n path
    cd =pull_cd(path)
    tile=pull_im path
    {:cd_type=>cd, :path=>path, :tile=>tile, :case_n=>case_n,:type=>:im_tile}
  end
end

def find_classification
  find_files(file_name_ending="*Classification.jpg").map do |x|
    x.merge({:type => :classification})
  end
end

def find_original
  find_files(file_name_ending="*Original.jpg").map do |x|
     x.merge({:type => :original})
   end
end

def find_statistics
  find_files(file_name_ending="*Statistics.csv").map do |x|
    puts x
    {:case_n=> x[:case_n],
     :path=> x[:path],
     :cd_type=>pull_cd(x[:path]),
    :type=> :statistic}
  end
end


def find_density
   find_files(file_name_ending="*densitymap*.jpg").map do |x|
    path=x[:path]
    case_n=get_case_n path
    new_old=path.gsub(".jpg","")[-3..-1]
    {:path=>path, :case_n=>case_n, :new_old=>new_old, 
      :cd_type=>pull_cd(path),:type=>:density}
  end
end

def find_histogram
  find_files(file_name_ending="*histogram.jpg").map do |x|
    path=x[:path]
    case_n=get_case_n path
    cd=pull_cd(path)
    {:path=>path, :case_n=>case_n,:type=>:histogram, :cd_type=>cd}
  end
end


#### merges all the JSON structures coming from the search functions
# some metaprogramming: calls all find functions listed above
def search_all
  r=[]
  [:find_histogram,:find_density,:find_statistics,:find_original, :find_classification, :find_im,:find_ct].each do |m|
    r << self.send(m)
    puts "Done with #{m}"
  end
  r.flatten
end


class NilClass
  def  to_sym
    false
  end
end


### query to ensure that entries are not recreated in teh database, but only paths and blobs are updated
def make_query data_set
  if data_set.has_key?(:new_old)
    query={:case_n => data_set[:case_n],:cd_type=>data_set[:cd_type], :new_old=>data_set[:new_old]}
  elsif data_set.has_key?(:tile)
    query={:case_n => data_set[:case_n],:cd_type=>data_set[:cd_type], :tile=>data_set[:tile]}
  else
    query={:case_n => data_set[:case_n],:cd_type=>data_set[:cd_type]}
  end
  query
end


#### load datasets in their mongo classes
#
# if entry preexisting updates results
#
#
def mongo_load_all search_results=search_all(), json_class_mapper=JSON_CLASS_MAPPER
  search_results.each_with_index do |data_set,i|
    puts "#{i}: #{data_set}"
    puts data_set["type"]
    mm_class=( json_class_mapper[data_set["type"]].to_sym or json_class_mapper[data_set[:type]])
    puts "mm_class=#{mm_class}"
    #puts "data set type=#{data_set[:type]}"
    puts "class =#{mm_class}"
    query=make_query data_set
    puts "query= #{query}"
    #query= {:case_n=>"RS-SV-05-16335", :cd_type=>"CD8", :tile=>"CT4"}
    if mm_class.where(query).all.empty?
      mm_object=mm_class.create data_set
      puts "mm created #{mm_object}"
    else
      # upserts if entry pre-existing
      mm_class.set(query, data_set, :upsert => true )
      puts "uspsert created #{mm_object}"
      mm_object=mm_class.where(data_set).find_one
    end
    #binding.pry
    mm_object.get_cd
    mm_object.save
   
  end
  puts "\n\n\n"
  puts "finished uploading to databes"
end

def show graphic_data
  tf=Tempfile.new ["temp",".jpg"]
  tf.write graphic_data
  tf.close
  puts "#{tf.path}"
  fork do
    `open #{tf.path}`
  end
  Process.wait
  tf.unlink
end


