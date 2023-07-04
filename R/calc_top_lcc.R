
#' Get the top n rows of the input data frame
#'
#' This function filters rows that have more than one distinct value
#' across all columns except the last one, and then selects the top n rows
#' based on the value of the last column.
#'
#' @param crosstab_result A data frame of  a frequency table crosstab_result must have a column named "Freq", representing the number of pixels / area for a given land cover change
#' (crosstab) of two or more land cover maps,
#' @param n_rows The number of rows to select.
#'
#' @return A data frame containing the top n rows (top n changes.
#'
#' @importFrom dplyr mutate_if rowwise filter ungroup top_n
#' @importFrom purrr is.factor
#' @export
calc_top_lcc <- function(crosstab_result, n_rows) {
  # Check if crosstab_result is a data frame
  if(!is.data.frame(crosstab_result)) {
    stop("crosstab_result must be a data frame")
  }

  # Check if crosstab_result has a column named "Freq"
  if(!"Freq" %in% names(crosstab_result)) {
    stop("crosstab_result must have a column named 'Freq'")
  }

  # Check if 'Freq' column contains numeric values
  if(!is.numeric(crosstab_result$Freq)) {
    stop("'Freq' column must contain numeric values")
  }

  # Check if n_rows is a single number
  if(!is.numeric(n_rows) || length(n_rows) != 1) {
    stop("n_rows must be a single number")
  }

  crosstab_result %>%               # Start with the 'crosstab_result' data frame.
    mutate_if(is.factor, as.character) %>%   # For each column, if it is a factor, convert it to character type.
    rowwise() %>%              # Change the operation mode to row-wise. This is useful for operations that need to be performed on each row individually.
    filter(n_distinct(c_across(-length(crosstab_result))) > 1) %>%  # Filter rows that have more than one distinct value across all columns except the last one.
    ungroup() %>%              # Remove the row-wise grouping.
    top_n(n_rows) %>% dplyr::arrange(desc(Freq))                # Select the top n_rows by value. By default, it selects by the last column in the data frame.
  }

