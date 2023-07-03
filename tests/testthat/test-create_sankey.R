library(testthat)

# Test that the function returns a sankeyNetwork - htmlwidget object
test_that("create_sankey returns a ggplot object", {

  # Apply your functiony
  result <- create_sankey(freq_table = crosstab_result)

  # Check the result
  expect_s3_class(result, "sankeyNetwork")
})





