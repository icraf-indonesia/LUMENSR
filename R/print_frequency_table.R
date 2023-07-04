#' Prints a frequency table as an HTML table using the gt package
#'
#' @author Dony Indiarto
#' @param df The data frame to convert into an HTML table.
#' @param title The title for the table. Default: "Top 10 Type of Land Cover Change".
#' @param labels A named vector of column labels to use in place of the original column names.
#' Names of the vector should match the column names in the df. Default: NULL (original names are used).
#' @param freq_col The name of the column to format as frequency. Default: "Freq".
#' @param table_width The width of the table in pixels. Default: 700.
#' @param font_size The font size in pixels. Default: 12.
#' @return A gt table object.
#' @importFrom gt gt tab_header cols_label fmt_number tab_options px
#' @importFrom magrittr %>%
#' @export
print_frequency_table <- function(df, title = "Dominant Type of Land Cover Change", labels = NULL, freq_col = "Freq",
                                  table_width = 700, font_size = 12) {

  # Check that df is a data frame
  if (!is.data.frame(df)) {
    stop("df must be a data frame.")
  }

  # Check that title is a string
  if (!is.character(title) || length(title) != 1) {
    stop("title must be a single string.")
  }

  # Check that labels is NULL or a named character vector
  if (!is.null(labels) && (!is.character(labels) || !is.null(setdiff(names(labels), names(df))))) {
    stop("labels must be a named character vector with names matching the column names in df.")
  }

  # Check that freq_col exists in df and is numeric
  if (!freq_col %in% names(df)) {
    stop("freq_col must be a column name in df.")
  }
  if (!is.numeric(df[[freq_col]])) {
    stop("freq_col must be a numeric column.")
  }

  # Check that table_width and font_size are numeric and positive
  if (!is.numeric(table_width) || length(table_width) != 1 || table_width <= 0) {
    stop("table_width must be a single positive number.")
  }
  if (!is.numeric(font_size) || length(font_size) != 1 || font_size <= 0) {
    stop("font_size must be a single positive number.")
  }

  # Create the table
  df %>%
    gt() %>%
    tab_header(title = title) %>%
    {
      if (!is.null(labels)) {
        . %>%
          cols_label(labels)
      } else {
        .
      }
    } %>%
    fmt_number(columns = c(!!sym(freq_col)), decimals = 0, use_seps = TRUE) %>%
    tab_options(table.width = px(table_width), table.font.size = px(font_size))
}
