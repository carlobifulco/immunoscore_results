require 'rubygems'
require 'bundler/setup'
require "yaml"
require_relative "../immunoscore_results_aggregator"
#!/usr/bin/env ruby
# coding: utf-8


require "thor"
require "date"



def check_config
  raise "cannot find definiens base directory.  please check and edit configuration file"    unless Dir.exists? BASE_DIR
  Dir.mkdir config["export_dir"] unless Dir.exists? EXPORT_DIR
end


class CliSummary < Thor                                                 # [1]
  package_name "Cli Summary"                                             # [2]
  #map "-L" => :list                                              # [3]

  # desc "install APP_NAME", "install one of the available apps"   # [4]
  # method_options :force => :boolean, :alias => :string           # [5]
  # def install(name)
  #   user_alias = options[:alias]
  #   if options.force?
  #     # do something
  #   end
  #   # other code
  # end

  # desc "list [SEARCH]", "list all of the available apps, limited by SEARCH"
  # def list(search="")
  #   # list everything
  # end
  desc "export_summary_csv [N]", "merges and exports all stat results; export filename as an argument "
  def export_summary_csv all_results_file_name="all_definiens_results_#{Date.today.to_s}.csv"
    write_stats_csv all_results_file_name
    puts "\n\n\n"
    puts "Results are available in #{all_results_file_name}"
    puts "\n\n\n"

  end

  desc "upload_data", "uploads definines immunoscore directory into mongo; no arguments"
  def upload_data
    check_config
    mongo_load_all
  end

  desc "export_data_struct", "exports data structure of all uploaded datasets; no arguments"
  def export_data_struct
    check_config
    export_mongo
  end

  desc "show_config", "shows config file; no arguments"
  def show_config
    ShowConfig.show_config
    begin 
      `emacs #{ShowConfig.show_config}`
    rescue
    end
  end



end


CliSummary.start(ARGV)