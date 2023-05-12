#' Create a Sankey Diagram
#'
#' This function takes a frequency table (crosstab) as input, filters the table to only include
#' rows where the frequency is greater than the average frequency, and creates a Sankey diagram
#' from the filtered table.
#'
#' @param crosstab_ A frequency table to be processed.
#' @param max_categories The maximum number of categories. Default is 15.
#' @param font_size The font size. Default is 10.
#' @param sinks_right If TRUE, sinks are on the right. Default is TRUE.
#' @param label_show_varname If FALSE, variable names are not shown. Default is FALSE.
#' @param node_position_automatic If TRUE, node position is automatic. Default is TRUE.
#' @param hovertext_show_percentages If FALSE, hover text does not show percentages. Default is FALSE.
#' @param label_show_percentages If FALSE, labels do not show percentages. Default is FALSE.
#' @param label_show_counts If FALSE, labels do not show counts. Default is FALSE.
#' @param link_color The color of the link. Default is "Source".
#' @param variables_share_values If TRUE, variables share values. Default is TRUE.
#'
#' @return A Sankey diagram.
#'
#' @importFrom dplyr mutate_if filter select
#' @importFrom flipPlots SankeyDiagram
#'
#' @examples
#' \dontrun{
#'   # Assume you have a crosstab_
#'   sankey_diagram <- create_sankey(crosstab_)
#' }
#'
#' @export
#'
create_sankey <- function(crosstab_, max_categories = 15, font_size = 10, sinks_right = TRUE,
                          label_show_varname = FALSE, node_position_automatic = TRUE,
                          hovertext_show_percentages = FALSE, label_show_percentages = FALSE,
                          label_show_counts = FALSE, link_color = "Source",
                          variables_share_values = TRUE) {

  if (!requireNamespace("flipPlots", quietly = TRUE)) {
    stop("Package 'flipPlots' is required. \n",
         "Please install it with: devtools::install_github('Displayr/flipPlots')")
  }

  # Create input for Sankey diagram
  input_sankey <- crosstab_ %>%
    mutate_if(is.character, as.factor) %>%
    filter(Freq>mean(Freq))

  # Generate Sankey diagram
  sankey_diagram <- input_sankey %>%
    select(-Freq) %>%
    flipPlots::SankeyDiagram(
      max.categories = max_categories,
      font.size = font_size,
      sinks.right = sinks_right,
      label.show.varname = label_show_varname,
      weights = input_sankey[["Freq"]],
      node.position.automatic = node_position_automatic,
      hovertext.show.percentages = hovertext_show_percentages,
      label.show.percentages = label_show_percentages,
      label.show.counts = label_show_counts,
      link.color = link_color,
      variables.share.values = variables_share_values
    )

  # Return the Sankey diagram
  return(sankey_diagram)
}
