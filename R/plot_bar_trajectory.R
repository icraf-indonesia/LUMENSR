#' Plot a Bar Chart of Trajectories
#'
#' This function creates a bar plot from a data frame with custom colors based on category names.
#' Categories containing "loss", "recovery", or "stable" are colored salmon, lightgreen, or lightblue, respectively.
#' All other categories are colored grey.
#'
#' @param df A data frame containing the data to plot. The first column should be the categories and the second column should be the numeric values.
#' @return A ggplot2 object representing the bar plot.
#' @importFrom ggplot2 ggplot aes geom_bar coord_flip theme_minimal theme labs element_text
#' @importFrom stringr str_detect
#' @export
#' @examples
#' \dontrun{
#' plot_bar_trajectory(table_traj_area)
#' }
plot_bar_trajectory <- function(df) {
  # Get the column names
  cat_col <- names(df)[1]
  val_col <- names(df)[2]

  # Convert first column to factor to maintain the order in the plot
  df[[cat_col]] <- factor(df[[cat_col]], levels = df[[cat_col]])

  # Create a function to assign colors based on category names
  assign_colors <- function(category) {
    category <- tolower(category)  # Convert to lower case
    if (stringr::str_detect(category, "loss")) {
      return("salmon")
    } else if (stringr::str_detect(category, "recovery")) {
      return("lightgreen")
    } else if (stringr::str_detect(category, "stable")) {
      return("lightblue")
    } else {
      return("grey")
    }
  }

  # Apply the function to the first column to create the color vector
  color_vector <- sapply(df[[cat_col]], assign_colors)

  # Create the plot
  barplot_traj <-
    ggplot2::ggplot(df, ggplot2::aes(
      x = reorder(.data[[cat_col]], .data[[val_col]]),
      y = .data[[val_col]],
      fill = .data[[cat_col]]
    )) +
    ggplot2::geom_bar(stat = "identity") +
    ggplot2::coord_flip() +  # Flip the axes
    ggplot2::scale_fill_manual(values = color_vector) +  # Use manual color scale
    ggplot2::theme_minimal() +  # Use minimal theme
    ggplot2::theme(
      axis.text.y = ggplot2::element_text(size = 12),
      # Increase y-axis label size
      axis.text.x = ggplot2::element_text(size = 12)   # Increase x-axis label size
    ) +
    ggplot2::labs(
      x = NULL,
      y = "Area",
      fill = "Category",
      title = NULL
    ) +
    ggplot2::theme(legend.position = "none")

  return(barplot_traj)
}
