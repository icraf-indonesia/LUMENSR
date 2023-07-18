# Test that the function returns a data frame
test_that("create_crosstab returns a data frame", {
  # Prepare a lookup table by abbreviating column 'PL20' in the predefined table 'lc_lookup_klhk_sequence'
  lookup_tbl <- lc_lookup_klhk_sequence %>% abbreviate_by_column(col_names = "PL20")

  lc_t1_ <- LUMENSR_example("NTT_LC90.tif") %>%
    terra::rast() %>%
    add_legend_to_categorical_raster(
      raster_file = .,
      lookup_table = lookup_tbl
    ) %>%
    assign_time_period(year_ = "1990")

  # Similarly, load the land cover data for period T2 (2020) and add the legend
  lc_t2_ <- LUMENSR_example("NTT_LC20.tif") %>%
    terra::rast() %>%
    add_legend_to_categorical_raster(
      raster_file = .,
      lookup_table = lookup_tbl
    ) %>%
    assign_time_period(year_ = "2020")

  admin_z <- ntt_admin %>%
    rasterise_multipolygon()

  # Turn raster files into a frequency table
  crosstab_result <- create_crosstab(land_cover = c(lc_t1_, lc_t2_), zone = admin_z)

  # Check the result
  expect_type(crosstab_result, "list")
  expect_s3_class(crosstab_result[["crosstab_long"]], "data.frame")

  # Test that the function removes rows with zero frequencies
  expect_true(all(crosstab_result[["crosstab_long"]] != 0))
})

