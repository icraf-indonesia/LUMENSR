#' Land Cover Frequency Plot
#'
#' This function generates a side by side bar plot comparing the frequency of land cover types in two different years.
#'
#' @param lc_table A data frame containing land cover types and their frequency in two different years.
#' @param column_lc_type The column name of land cover types in lc_table.
#' @param column_T1 The column name of the frequency data for Timepoint 1 in lc_table.
#' @param column_T2 The column name of the frequency data for Timepoint 2 in lc_table.
#'
#' @return A ggplot object representing the side by side bar plot.
#' @export
#'
#' @importFrom dplyr mutate
#' @importFrom ggplot2 ggplot aes geom_bar scale_x_reverse coord_cartesian labs theme_minimal theme geom_blank theme_void scale_x_continuous margin
#' @importFrom forcats fct_reorder
#' @importFrom cowplot plot_grid
#' @importFrom stringr str_wrap
#' @importFrom tidyr replace_na pivot_longer
#' @importFrom rlang :=
#'
#' @examples
#'  \dontrun{
#' plot_lc_freq(lc_table = lc_tbl,
#'              column_lc_type = "Jenis tutupan lahan",
#'              column_T1 = "NTT_LC90_count",
#'              column_T2 = "NTT_LC20_count")
#' }

plot_lc_freq <- function(lc_table, column_lc_type, column_T1, column_T2) {
  # Validate inputs
  stopifnot(is.data.frame(lc_table))
  stopifnot(is.character(column_lc_type))
  stopifnot(is.character(column_T1))
  stopifnot(is.character(column_T2))

  # Replace NA values with 0
  lc_table <- lc_table %>%
    mutate(!!sym(column_T1) := replace_na(!!sym(column_T1), 0),
           !!sym(column_T2) := replace_na(!!sym(column_T2), 0))

  # Reshape data to long format. This structure is more suitable for plotting.
  lc_table_long <- lc_table %>%
    pivot_longer(cols = c(column_T1, column_T2),
                 names_to = "Year",
                 values_to = "Count")

  # Define the maximum range for the x-axis
  max_range <- max(lc_table_long$Count, na.rm = TRUE)

  # Reorder the factor levels of Land_Cover_Type based on the count from Timepoint 1 data
  lc_table_T1 <- lc_table %>%
    mutate(!!column_lc_type := fct_reorder(!!sym(column_lc_type), !!sym(column_T1)))

  # Create lc_table_long with new level order
  lc_table_long <- lc_table_T1 %>%
    pivot_longer(cols = c(column_T1, column_T2),
                 names_to = "Year",
                 values_to = "Count")

  # Wrap the text of Land_Cover_Type to make it fit into two lines
  lc_table_long[[column_lc_type]] <- factor(str_wrap(as.character(lc_table_long[[column_lc_type]]), width = 30))


  # Create the Timepoint 1 plot with positive values
  plot1 <- ggplot(lc_table_long[lc_table_long$Year == column_T1,],
                  aes(x = Count, y = .data[[column_lc_type]])) +
    geom_bar(stat = "identity", fill = "lightblue") +
    scale_x_reverse(breaks = seq(0, max_range, by = 500000),
                    labels = function(x) format(abs(x), big.mark = ",", scientific = FALSE)) +
    coord_cartesian(xlim = c(max_range,0)) +
    labs(x = paste("Count -", column_T1), y = "") +
    theme_minimal() +
    theme(plot.margin = margin(5.5, 50, 5.5, 5.5),
          axis.text.y = element_blank())

  # Create the Timepoint 2 plot with negative values
  plot2 <- ggplot(lc_table_long[lc_table_long$Year == column_T2,],
                  aes(x = Count, y = .data[[column_lc_type]])) +
    geom_bar(stat = "identity", fill = "salmon") +
    labs(x = paste("Count -", column_T2), y = "") +
    scale_x_continuous(limits = c(0, max_range),
                       breaks = seq(0, max_range, by = 500000),
                       labels = function(x) format(abs(x), big.mark = ",", scientific = FALSE)) +
    theme_minimal() +
    theme(plot.margin = margin(5.5, 5.5, 5.5, 50),
          axis.text.y = element_blank())

  # Create the label plot. This is the middle plot which just shows the land cover types.
  lc_label <- ggplot(lc_table_long, aes(y = .data[[column_lc_type]])) +
    geom_blank() +
    theme_void() +
    theme(axis.text.y = element_text(angle = 0, hjust = 0.5))

  # Arrange the plots side by side using the cowplot package
  final_plot <- plot_grid(plot1, lc_label, plot2, align = "h", nrow = 1, rel_widths = c(1, 0.2, 1))

  return(final_plot)
}

