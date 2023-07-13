#' Create a plot of a spatial planning unit with labels.
#'
#' This function creates a plot using ggplot2 where each planning unit is
#' represented as a polygon filled with light green color. The unit names
#' are added as text labels that repel each other to minimize overlap.
#'
#' @param planning_unit A sf object representing the planning units.
#' @param map_label A string representing the column name to use for labels. If empty, the second column of planning_unit is used.
#'
#' @return A ggplot object.
#'
#' @importFrom ggplot2 ggplot geom_sf theme_minimal
#' @importFrom ggrepel geom_text_repel
#' @importFrom sf st_is
#' @importFrom rlang !! sym
#' @export
plot_planning_unit <- function(planning_unit, map_label = NULL) {
  # Check if planning_unit is a sf object
  if(!inherits(planning_unit, "sf")) {
    stop("planning_unit must be an sf object")
  }

  # Check if planning_unit is a MULTIPOLYGON
  if(!any(st_is(planning_unit, "MULTIPOLYGON"))) {
    stop("planning_unit must be a MULTIPOLYGON")
  }

  # Check if planning_unit has a column named "geometry"
  if(!"geometry" %in% names(planning_unit)) {
    stop("planning_unit must have a column named 'geometry'")
  }

  # If map_label is not provided, use the second column
  if(is.null(map_label)) {
    map_label <- names(planning_unit)[2]
  }

  # Check if map_label is a string that is present among the names of the sf polygon attribute table
  if(!is.character(map_label) || length(map_label) != 1 || !(map_label %in% names(planning_unit))) {
    stop("map_label must be a string that is present among the names of the sf polygon attribute table")
  }

  ggplot() +
    geom_sf(data = planning_unit, fill = "lightgreen", color = "black", size = 0.2) +
    ggrepel::geom_text_repel(
      data = planning_unit,
      aes(label = !!sym(map_label), geometry = geometry),
      stat = "sf_coordinates",
      color = "grey30",     # text color
      bg.color = "white", # shadow color
      bg.r = 0.15 ,
      box.padding = 2,
      force = 1,
      max.overlaps = Inf
    ) +      # shadow radius) +
    theme_minimal()
}
