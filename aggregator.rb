class StatResults
  include MongoMapper::Document
  include DataUtilities
  include CdIncluder
  include Show
  extend ClassDataUtilities
  safe
  timestamps!
  key :file_name, String
  key :tissue_detection_threshold, Integer
  key :brown_threshold, Integer
  key :mean_brown, Integer
  key :median_brown, Float
  key :sd_brown, Float
  key :minimum_brown, Integer
  key :maximum_brown, Float
  key :mean_3_most_infiltrated_ct, Integer
  key :density_ct_tile_1, Integer
  key :area_ct_tile_1, Integer
  key :number_of_cells_ct_tile_1, Integer
  key :density_ct_tile_2, Integer
  key :area_ct_tile_2, Integer
  key :number_of_cells_ct_tile_2, Integer
  key :density_ct_tile_3, Integer
  key :area_ct_tile_3, Integer
  key :number_of_cells_ct_tile_3, Integer
  key :density_ct_tile_4, Integer
  key :area_ct_tile_4, Integer
  key :number_of_cells_ct_tile_4, Integer
  key :density_ct_tile_5, Integer
  key :area_ct_tile_5, Integer
  key :number_of_cells_ct_tile_5, Integer
  key :mean_3_most_infiltrated_im, Integer
  key :density_im_tile_1, Integer
  key :area_im_tile_1, Integer
  key :number_of_cells_im_tile_1, Integer
  key :density_im_tile_2, Integer
  key :area_im_tile_2, Integer
  key :number_of_cells_im_tile_2, Integer
  key :density_im_tile_3, Integer
  key :area_im_tile_3, Integer
  key :number_of_cells_im_tile_3, Integer
  key :density_im_tile_4, Integer
  key :area_im_tile_4, Integer
  key :number_of_cells_im_tile_4, Integer
  key :density_im_tile_5, Integer
  key :area_im_tile_5, Integer
  key :number_of_cells_im_tile_5, Integer
  key :old_mean_3_most_infiltrated_ct, Integer
  key :old_density_ct_tile_1, Integer
  key :old_area_ct_tile_1, Integer
  key :old_number_of_cells_ct_tile_1, Integer
  key :old_density_ct_tile_2, Integer
  key :old_area_ct_tile_2, Integer
  key :old_number_of_cells_ct_tile_2, Integer
  key :old_density_ct_tile_3, Integer
  key :old_area_ct_tile_3, Integer
  key :old_number_of_cells_ct_tile_3, Integer
  key :old_density_ct_tile_4, Integer
  key :old_area_ct_tile_4, Integer
  key :old_number_of_cells_ct_tile_4, Integer
  key :old_density_ct_tile_5, Integer
  key :old_area_ct_tile_5, Integer
  key :old_number_of_cells_ct_tile_5, Integer
  key :old_mean_3_most_infiltrated_im, Integer
  key :old_density_im_tile_1, Integer
  key :old_area_im_tile_1, Integer
  key :old_number_of_cells_im_tile_1, Integer
  key :old_density_im_tile_2, Integer
  key :old_area_im_tile_2, Integer
  key :old_number_of_cells_im_tile_2, Integer
  key :old_density_im_tile_3, Integer
  key :old_area_im_tile_3, Integer
  key :old_number_of_cells_im_tile_3, Integer
  key :old_density_im_tile_4, Integer
  key :old_area_im_tile_4, Integer
  key :old_number_of_cells_im_tile_4, Integer
  key :old_density_im_tile_5, Integer
  key :old_area_im_tile_5, Integer
  key :old_number_of_cells_im_tile_5, Integer
end
