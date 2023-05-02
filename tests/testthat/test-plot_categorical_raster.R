
kalbar_LC11 <- LUMENSR_example("kalbar_LC11.tif")
kalbar_LC11 <-  terra::rast(kalbar_LC11)
kalbar_LC11_att <- add_legend_to_categorical_raster(raster_file = kalbar_LC11, lookup_table = lc_lookup_klhk)
#plot_categorical_raster(kalbar_LC11_att)

test_that("plot_categorical_raster returns a ggplot object", {
  result_plot <- plot_categorical_raster(kalbar_LC11_att)
  expect_s3_class(result_plot, "ggplot")
})
