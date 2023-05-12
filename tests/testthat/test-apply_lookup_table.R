# Load the LUMENSR package
library(LUMENSR)
library(terra)
library(tibble)


# Load the 2011 land cover raster for the Kalbar region
kalbar_2011 <- rast(LUMENSR_example("kalbar_LC11.tif"))

# Classify the raster and apply the lookup table
kalbar_2011_legend <- apply_lookup_table(kalbar_2011, lc_lookup_klhk)

test_that("classify_raster() works as expected", {
  # Check that result is a spatraster object
  expect_s4_class(kalbar_2011_legend, "SpatRaster")

  # Check that the classified raster has the correct number of classes
  n_class <- kalbar_2011_legend %>% terra::unique() %>% tibble() %>% base::nrow()
  expect_lt(n_class, nrow(lc_lookup_klhk))

})
