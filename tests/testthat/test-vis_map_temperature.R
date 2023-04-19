library(testthat)

# Test if function returns a ggplot object
test_that("vis_map_temperature returns a ggplot object", {
  ntt_temp_path <- LUMENSR_example("ntt_temp.tif")
  ntt_temp <-  terra::rast(ntt_temp_path)
  plot <- vis_map_temperature(temperature_data = ntt_temp, boundary_data = ntt_admin)
  expect_true(inherits(plot, "ggplot"))
})
