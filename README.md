immunoscore_results_aggregator
===========================


- Extracts and aggregates results from the definiens immunoscore plugin to enable validation of region of interest selection and of hotspots
- Uploads results to a nosql database (mongodb)

Enables exporting of results as:

- Properly structured data directory containing essential files for review 
- As a CSV statistics summary file containing datasets for further analysis (e.g. R)


### Mongodb datastructure

####Example of immunoscore qa/qc entries: 

<img src='https://notationalvelocity.s3.amazonaws.com/1-2014-09-24-11-05-11--0700.png?AWSAccessKeyId=AKIAIHNTWDGBIXEE6HEA&Signature=pXx5128pctDb72XDfTru2QcNCCU%3D&Expires=2042733911' width=' ' height=' '>  </img>


#### Example of data structure of each entry:

<img src='https://notationalvelocity.s3.amazonaws.com/3-2014-09-24-11-14-16--0700.png?AWSAccessKeyId=AKIAIHNTWDGBIXEE6HEA&Signature=DqQgv7WcgCbtjzh0g51dEUx75y8%3D&Expires=2042734457' width=' ' height=' '>  </img>

Each entry contains file paths, a binary blob of the relevant snapshot, case number and relevant annotation. 


Requirements
===========
 *nix
 ruby > 2.0

Installation
=========
download zip from https://github.com/carlobifulco/immunoscore_results and unzip or alternatively clone the github repository

cd in the code directory
bundle
bundle install


Setup
=====

Edit config.yaml to setup the root of the immunoscore directory tree, choose a mongodb name,  and a name for the results export directory

<img src='https://notationalvelocity.s3.amazonaws.com/4-2014-09-24-12-02-23--0700.png?AWSAccessKeyId=AKIAIHNTWDGBIXEE6HEA&Signature=R8oDkvDRMRCMZ5hgRFxNQ5pykTI%3D&Expires=2042737344' width=' ' height=' '>  </img>

Run
====

ruby cli.rb -h

