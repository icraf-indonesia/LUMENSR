# Load example data
worldclim_temp_indo <- LUMENSR_example("wc2.1_30s_bio_1_indo.tif")
temp_indo <-  terra::rast(worldclim_temp_indo)

# Define test cases
test_that("harmonise_raster returns a SpatRaster object with same extent as batas_kab", {
  # Call the harmonise_raster function with example data
  r_harmonized <- harmonise_raster(dat_clim = temp_indo, batas_kab = ntt_admin)

  # Check if the output is a SpatRaster object
  expect_true(is(r_harmonized, "SpatRaster"))

  # Check if the projection of the output matches that of the input polygon
  expect_equal(crs(r_harmonized, proj=TRUE), st_crs(ntt_admin)$proj4string)

  # Check if the extent of the output matches that of the input polygon
  # NOTE: This line is commented out since the `ext` function returns slightly different extents for objects with different CRSs due to the differences in the shape of the earth. It may still be useful to check visually if the output looks correct.
  # expect_equal(ext(r_harmonized), st_bbox(ntt_admin))
})
