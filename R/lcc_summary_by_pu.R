#' Summarize land cover changes by planning unit
#'
#' This function provides a summary of land cover changes for specified planning units. It returns a sankey plot and the top land cover changes.
#'
#' @param crosstab_tbl A data frame containing at least 2 columns of land cover types (could be character, numeric, or factor) and a "Freq" column containing numeric values.
#' @param pu_column A character string representing the column name of the planning unit in `crosstab_tbl`.
#' @param pu_name A character string representing the name of the planning unit.
#' @param sankey_area_cutoff A numeric value indicating the minimum area of changes to be displayed in the Sankey plot.
#' @param n_top_lcc An integer representing the number of top land cover changes to be displayed. Default is 10.
#' @return A list containing the Sankey plot (`sankey_pu`) and a data frame of the top land cover changes (`luc_top_pu`).
#' @importFrom dplyr filter select
#' @importFrom rlang sym
#' @export
lcc_summary_by_pu <- function(crosstab_tbl, pu_column, pu_name, sankey_area_cutoff, n_top_lcc = 10){
  # Error checking
  if (!inherits(crosstab_tbl, "data.frame")) stop("crosstab_tbl must be a data frame.")
  if (!is.character(pu_column)) stop("pu_column must be a character string.")
  if (!is.numeric(sankey_area_cutoff)) stop("sankey_area_cutoff must be a numeric value.")
  if (!is.numeric(n_top_lcc)) stop("n_top_lcc must be an integer.")

  # Check if the required columns exist in the data frame
  if (!pu_column %in% names(crosstab_tbl)) stop(paste("The data frame does not contain the column:", pu_column))
  if (!"Freq" %in% names(crosstab_tbl)) stop("The data frame does not contain the column: Freq")

  # Filter the crosstab table based on planning unit and remove the planning unit column
  filter_crosstab <- crosstab_tbl %>%
    dplyr::filter(!!sym(pu_column) %in% pu_name) %>%
    dplyr::select(-!!sym(pu_column))

  # Create a Sankey plot based on the filtered crosstab table
  sankey_pu <- filter_crosstab %>%
    create_sankey(area_cutoff = sankey_area_cutoff, change_only = FALSE)

  # Calculate the top land cover changes based on the filtered crosstab table
  luc_top_pu <- filter_crosstab %>%
    calc_top_lcc(n_rows = n_top_lcc)

  # Return a list containing the Sankey plot and the top land cover changes
  return(list(sankey_pu = sankey_pu, luc_top_pu = luc_top_pu))
}

