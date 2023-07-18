#' Create a Sankey Diagram
#'
#' This function takes a frequency table (crosstab) as input and creates a Sankey diagram.
#' If a column named "Ha" exists in the frequency table, it will be used for filtering and sorting,
#' otherwise it will fall back to using the "Freq" column.
#'
#' @author Dony Indiarto
#' @param freq_table A frequency table containing land cover T1, T2, T3, etc..
#' and a Frequency column (numeric). If a column named "Ha" exists, it will be used instead of "Freq".
#' @param area_cutoff Minimum number of pixels of land use land cover frequency to include.
#' @param change_only Logical flag, if TRUE exclude persistent land cover.
#' @return A Sankey plot.
#' @importFrom dplyr mutate_if rowwise filter ungroup mutate across cur_column n_distinct c_across
#' @importFrom rlang sym !!
#' @importFrom networkD3 sankeyNetwork
#' @export
#' @examples
#' \dontrun{
#'   synthetic_data <- data.frame(
#'     "1990" = rep(c("Forest", "Urban", "Agriculture", "Water"), each = 4),
#'     "2020" = rep(c("Forest", "Urban", "Agriculture", "Water"), 4),
#'     Freq = sample(1:100, 16)
#'   ) %>%
#'     dplyr::arrange("1990")
#'
#'   create_sankey(freq_table = synthetic_data, area_cutoff = 0, change_only = FALSE)
#' }
create_sankey <- function(freq_table, area_cutoff = 10000, change_only = FALSE) {

  # Check if "Freq" column exists and is numeric
  if (!"Freq" %in% colnames(freq_table)) {
    stop("The 'Freq' column does not exist in the data frame.")
  }

  if (!is.numeric(freq_table$Freq)) {
    stop("The 'Freq' column should contain numeric values.")
  }

  # Check if "Ha" column exists
  if ("Ha" %in% colnames(freq_table)) {
    # Drop "Freq" column
    freq_table <- freq_table[ , !names(freq_table) %in% "Freq"]
    value_col <- "Ha"
  } else {
    value_col <- "Freq"
  }

  if(change_only){
    df_filtered <- freq_table %>%
      mutate_if(is.factor, as.character) %>%
      rowwise() %>%
      filter(n_distinct(c_across(-length(freq_table))) > 1) %>%
      ungroup() %>%
      filter((!!sym(value_col)) > area_cutoff)
  } else {
    df_filtered <- freq_table %>%
      dplyr::filter((!!sym(value_col)) > area_cutoff)
  }

  # Error handling: if dataframe is empty after filtering
  if(nrow(df_filtered) == 0){
    stop("No data left after filtering, please check your inputs.")
  }

  # Get column names (years) without the 'X' prefix and 'Freq'
  colnames_ <- sub("^X", "", names(df_filtered)[-length(names(df_filtered))])

  # Use lapply to paste each value with the corresponding year
  df_modified <- df_filtered
  df_modified[-length(names(df_modified))] <- lapply(seq_along(colnames_), function(i)
    paste(df_filtered[[i]], "-", colnames_[i], sep = ""))

  # # Apply the suffixes to the selected columns
  # df_filtered <- df_filtered %>%
  #   mutate(across(-length(df_filtered), ~paste(., paste0("_T", which(names(df_filtered) == cur_column())), sep = "")))

  sankey_data <- df_modified %>%
    prepare_sankey(col_order = setdiff(colnames(df_modified), value_col), value_col = value_col)

  # Add a 'group' column to the 'links' and 'nodes' data frames
  sankey_data$links <- sankey_data$links %>% mutate(group = sankey_data$nodes$name[source + 1])
  sankey_data$nodes <- sankey_data$nodes %>% mutate(group = name)

  # Create the Sankey plot
  sankey_plot <- sankeyNetwork(Links = sankey_data$links, Nodes = sankey_data$nodes, Source = "source",
                               Target = "target", Value = "value", NodeID = "name",
                               fontSize = 20, nodeWidth = 30, LinkGroup = "group", NodeGroup = "group"#,colourScale = color_scale
  )

  return(sankey_plot)
}
