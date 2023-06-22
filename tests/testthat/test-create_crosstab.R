library(testthat)
library(magrittr)
library(purrr)

# Test that the function returns a data frame
test_that("create_crosstab returns a data frame", {
  # Load some test data, for example:
  subset_legend <- LUMENSR::lc_lookup_klhk
  raster_files <- c("kalbar_LC11.tif", "kalbar_LC20.tif") %>%
    map(LUMENSR_example) %>%
    map(rast)

  # Loop through raster files
  raster_list <- map(raster_files,
                     ~apply_lookup_table(raster_file = .x,
                                         lookup_lc = subset_legend))

  # Turn raster files into a frequency table
  crosstab_result <- create_crosstab(raster_list)

  # Check the result
  expect_s3_class(crosstab_result, "data.frame")

  # Test that the function removes rows with zero frequencies
  expect_true(all(crosstab_result$Freq != 0))
})

