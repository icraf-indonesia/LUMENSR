library(terra)
library(dplyr)
# Load or create example data for testing
# Load example data
kalbar_LC11 <- LUMENSR_example("kalbar_LC11.tif")
kalbar_LC11 <-  terra::rast(kalbar_LC11)

lc_lookup_test <- lc_lookup_klhk %>%
  filter(!Value %in% c(2004, 2500, 3000)) %>%
  tibble::add_row(Value=0, PL20 ="No Data")


# Test that attribute values are added to the raster file
test_that("add_legend_to_categorical_raster adds attribute values to the raster file", {
  result_raster <- add_legend_to_categorical_raster(kalbar_LC11, lc_lookup_klhk)

  # Check if the input is a SpatRaster
  expect_s4_class(kalbar_LC11, "SpatRaster")

  # Check if the result is a SpatRaster
  expect_s4_class(result_raster, "SpatRaster")

  # Check if the attribute table is added
  expect_equal(sort(na.omit(unique(terra::values(result_raster)))),
               sort(lc_lookup_test$Value))
})
