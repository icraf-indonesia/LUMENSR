library(testthat)

# Test that the function returns a sankeyNetwork - htmlwidget object
test_that("create_sankey returns a ggplot object", {
  synthetic_data <- data.frame(
    Landcover_T1 = rep(c("Forest", "Urban", "Agriculture", "Water"), each = 4),
    Landcover_T2 = rep(c("Forest", "Urban", "Agriculture", "Water"), 4),
    Freq = sample(1:100, 16)
  ) %>%
    dplyr::arrange(Landcover_T1)

  # Apply your functiony
  result <- create_sankey(freq_table = synthetic_data, area_cutoff = 0, change_only = FALSE)

  # Check the result
  expect_s3_class(result, "sankeyNetwork")
})





