library(testthat)
library(flipPlots)

# Test that the function returns a sankeyNetwork - htmlwidget object
test_that("create_sankey returns a ggplot object", {
  # Load some test data, for example:
  load("data/crosstab_kalbar_LC_11_20.rda")

  # Apply your functiony
  result <- create_sankey(crosstab_ = crosstab_result)

  # Check the result
  expect_s3_class(result, "sankeyNetwork")
})





