#' Plot Frequency or Area of Land Cover Change as a Bar Chart
#'
#' This function takes in a data frame and plots the frequency or area of land cover changes as a bar chart.
#' It automatically detects if a column named "Ha" exists, and if so, it plots data using "Ha" as a priority
#' over "Freq". If "Ha" does not exist, it defaults back to using "Freq".
#'
#' @importFrom ggplot2 ggplot aes geom_bar coord_flip labs theme_minimal scale_y_continuous
#' @importFrom stringr str_wrap
#' @importFrom scales comma
#' @importFrom viridis scale_fill_viridis
#' @importFrom dplyr select_if
#' @importFrom stats reorder
#'
#' @param lcc_table A data frame containing at least two columns of characters and one column of numeric values.
#' @param col_T1 First column of characters. If NULL, the function will assign the first column containing characters.
#' @param col_T2 Second column of characters. If NULL, the function will assign the second column containing characters.
#' @param Freq Numeric column representing frequencies or areas. If NULL, the function will assign "Ha" if present,
#' otherwise the first numeric column.
#'
#' @return A ggplot object showing the frequency or area of land cover changes as a bar chart.
#'
#' @examples
#' \dontrun{
#' plot_lcc_freq_bar(lcc_table = luc_top_10, col_T1 = NULL, col_T2 =NULL, Freq =NULL)
#' }
#' @export

plot_lcc_freq_bar <- function(lcc_table, col_T1 = NULL, col_T2 = NULL, Freq = NULL) {

  # If col_T1 and col_T2 are NULL, find the first and second character columns
  if(is.null(col_T1) | is.null(col_T2)) {
    char_cols <- names(select_if(lcc_table, is.character))
    if(is.null(col_T1)) {
      col_T1 <- char_cols[1]
    }
    if(is.null(col_T2)) {
      col_T2 <- char_cols[2]
    }
  }

  # If both "Ha" and "Freq" are present, use "Ha"
  if("Ha" %in% names(lcc_table)) {
    Freq <- "Ha"
  }
  # If Freq is NULL and "Ha" is not present, find the first numeric column
  else if(is.null(Freq)) {
    Freq <- names(select_if(lcc_table, is.numeric))[1]
  }

  # Create a new combined label by concatenating the two character columns
  lcc_table[["label"]] <- apply(lcc_table[c(col_T1, col_T2)], 1, paste, collapse = " to ")

  # Wrap the text to a maximum width of 30 characters
  lcc_table[["label"]] <- str_wrap( lcc_table[["label"]], width = 30)

  # Plot the data
  p <- ggplot(lcc_table, aes(x=reorder(label, !!sym(Freq)), y= !!sym(Freq), fill= !!sym(Freq))) +
    geom_bar(stat = "identity") +
    coord_flip() +
    labs(x = "Land Cover Change", y = Freq, fill = Freq) +
    theme_minimal() +
    scale_y_continuous(labels = comma) +
    viridis::scale_fill_viridis(discrete = FALSE, direction = -1, guide = "none", labels = comma)

  return(p)
}

