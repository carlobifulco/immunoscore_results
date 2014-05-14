require_relative "analyzer"
require_relative "immunoscore_results_loader"

### Specify Database name; dynamic based on dir
DATABASE_NAME=File.basename File.absolute_path "."
MongoMapper.database = DATABASE_NAME

# module Show
#   def show file_path=self.path
#     tf=Tempfile.new ["temp",File.extname(file_path)]
#     tf.write (File.read file_path)
#     tf.close
#     puts "#{tf.path}"
#     fork do
#       `open #{tf.path}`

#     end
#     puts Process.waitall
#     tf.unlink
#   end
# end

### Enables all Mongo classes listed below to have instances capable their own CD quicly
module CdIncluder
  def get_cd
    puts self.cd_type
    if (self.cd_type and self.case_n) != nil 
      cd= Cd.get(self.cd_type, self.case_n)
    end
    puts cd
    if cd
      self.cd=cd
    end
    self.save
  end
end

### enables loading and showing of binary datatsets
module BinManager
  def load_bin
    self.data_load=File.read path
  end
  
  def show graphic_data=self.data_load
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
end

class ImmunoScoreResults
  include MongoMapper::Document
  include DataUtilities
  safe
  timestamps!
  many :cd
  key :case_n, String

  def self.get case_n
    self.find_by_case_n(case_n) or self.create(:case_n=>case_n)
  end

end


class Cd
  include MongoMapper::Document
  include DataUtilities
  safe
  timestamps!
  belongs_to :immuno_score_results
  key :cd_type, String
  key :case_n, String
  many :ct_tile
  many :im_tile
  many :statistic
  many :classification
  many :original
  many :density
  many :histogram

  #either get a brand new cd with its own Immunoscore Results instance of find a preexisting one
  def self.get cd_type, case_n
    self.find_by_cd_type_and_case_n(cd_type,case_n) or self.create(:case_n=>case_n, 
                                                                      :cd_type=>cd_type,
                                                                      :immuno_score_results_id=>ImmunoScoreResults.get(case_n)._id)
  end
end




  # {:cd=>"CD3",
  # :path=>
  #  "/Volumes/LaCie/patient 1-5/patient 1-5/results/RS_SM02-2576-A4_CD3_2013-11-01 16_52_41.image_0000006553/View_Exports
  # :tile=>"CT2",
  # :case_n=>"SM02-2576-A4",
  # :type=>:ct_tile}}

class CtTile
  include MongoMapper::Document
  include DataUtilities
  include CdIncluder
  include BinManager
  extend ClassDataUtilities
  safe
  timestamps!
  belongs_to :cd
  key :tile, String
  key :path, String
  key :case_n, String
  key :cd_type, String
  key :data_load, Binary
  before_save :load_bin
end



class ImTile
  include MongoMapper::Document
  include DataUtilities
  include CdIncluder
  include BinManager
  extend ClassDataUtilities
  safe
  timestamps!
  belongs_to :cd
  key :tile, String
  key :path, String
  key :case_n, String
  key :cd_type, String
  key :data_load, Binary
  before_save :load_bin
end

# {:case=>"SM02-2456-A6",
#   :cd=>"CD8",
#   :path=>
#    "/Volumes/LaCie/patient 1-5/patient 1-5/results/RS_SM02-2456-A6_CD8_2013-11-01 14_27_27.image_0000006515/image_000000
#   :type=>:classification},
class Classification
  include MongoMapper::Document
  include DataUtilities
  include CdIncluder
  include BinManager
  extend ClassDataUtilities
  safe
  timestamps!
  belongs_to :cd
  key :path, String
  key :case_n, String
  key :cd_type, String
  key :data_load, Binary
  before_save :load_bin
end

class Original
  include MongoMapper::Document
  include DataUtilities
  include CdIncluder
  include BinManager
  extend ClassDataUtilities
  safe
  timestamps!
  belongs_to :cd
  key :path, String
  key :case_n, String
  key :cd_type, String
  key :data_load, Binary
  before_save :load_bin
end

 # {:case=>"RS_SM02-2576-A4_CD3_2013-11-01 16_52_41.image_0000006553",
 #  :path=>
 #   "/Volumes/LaCie/patient 1-5/patient 1-5/results/RS_SM02-2576-A4_CD3_2013-11-01 16_52_41.image_0000006553/Statistic_Exports/RS_SM02-2576-A4_CD3_2013-11-01 16_52_41.image_0000006553_Statistics.csv",
 #  :cd=>"CD3",
 #  :type=>:statistics}

class Statistic
  include MongoMapper::Document
  include DataUtilities
  include CdIncluder
  include BinManager
  extend ClassDataUtilities
  safe
  timestamps!
  belongs_to :cd
  key :path, String
  key :case_n, String
  key :cd_type, String
  key :data_load, Binary
  before_save :load_bin
end


 # {:path=>
 #   "/Volumes/LaCie/patient 1-5/patient 1-5/results/RS_SM02-2576-A4_CD3_2013-11-01 16_52_41.image_0000006553/View_Exports
 #  :case=>"SM02-2576-A4",
 #  :new_old=>"old",
 #  :cd=>"CD3",
 #  :type=>"density"}
class Density
  include MongoMapper::Document
  include DataUtilities
  include CdIncluder
  include BinManager
  extend ClassDataUtilities
  safe
  timestamps!
  belongs_to :cd
  key :path, String
  key :case_n, String
  key :cd_type, String
  key :new_old, String
  key :data_load, Binary
  before_save :load_bin
end


 # {:path=>
 #   "/Volumes/LaCie/patient 1-5/patient 1-5/results/RS_SM02-2366-A5_CD8_2013-11-01 16_55_57.image_0000006556/View_Exports
 #  :case=>"SM02-2366-A5",
 #  :type=>:histogram,
 #  :cd=>"CD8"}
class Histogram
  include MongoMapper::Document
  include DataUtilities
  include CdIncluder
  include BinManager
  extend ClassDataUtilities
  safe
  timestamps!
  belongs_to :cd
  key :path, String
  key :case_n, String
  key :cd_type, String
  key :data_load, Binary
  before_save :load_bin
end


class Test
  include MongoMapper::Document
  include DataUtilities
  include CdIncluder
  include BinManager
  extend ClassDataUtilities
 
  key :path, String
  
  key :data_load, Binary
  before_save :load_bin


end

JSON_CLASS_MAPPER={:ct_tile=>CtTile,
  :im_tile=>ImTile,
  :classification=>Classification,
  :original=>Original,
  :statistic=>Statistic,
  :density=>Density,
  :histogram=>Histogram}



def mm_clean_all
  [ImmunoScoreResults, Cd, Histogram, Density, Statistic, Original, Classification, ImTile, CtTile].each do |mm_class|
    mm_class.delete_all
  end
end