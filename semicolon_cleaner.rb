

### Cleaning of the Definines semicolon junk
class DefinensCSV

  def initialize file_path
    @file_path=file_path
    @text=File.read @file_path
    #puts @text.encode("UTF-8")
    #clean utf not sure why
    _digest_utf
    #header_line
    csv=CSV.read(@file_path)
    if (csv and csv.count !=0)
      puts @file_path
      header=csv[0][0]
      if header.count(";")>header.count(",") then _parse_semicolon end
    end

    #parse_semicolon
  end


  def _digest_utf
    text=File.read @file_path
    text=text.encode("UTF-16BE", :invalid=>:replace, :replace=>"?").encode("UTF-8")
    fh=File.new @file_path, "w"
    fh.write text
    fh.close
    self
  end

  #replaces ; from definins csv with ,
  def _parse_semicolon
    #puts "removing semicolons"
    c=CSV.table @file_path, :col_sep=> ";"
    fh=File.new @file_path, "w"
    fh.write c.to_csv
    fh.close
    self
  end

  def table
    c=CSV.table @file_path
  end

  def get_dictionary
    table =self.table
    dictionary={}
    table.headers.each do |h|
      dictionary[h]=table[h][0] if table[h]
    end
    dictionary
  end
end


def csv_clean_all match_pattern="*.csv", root_directory_path=BASE_DIR
  csv_matches=Dir.glob "#{File.absolute_path root_directory_path}/**/#{match_pattern}"
  csv_matches.each do |cm|
    begin
      DefinensCSV.new cm
    rescue
      puts "FAILED on #{cm}"
    end
  end
end

