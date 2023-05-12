#' Plot categorical raster
#'
#' This function plots a categorical raster file using ggplot2.
#'
#' @param raster_object A categorical raster file (an object of class SpatRaster)
#' @return A ggplot map
#' @export
#' @importFrom tidyterra scale_fill_hypso_d geom_spatraster
#' @importFrom ggplot2 ggplot theme_bw labs
#' @examples
#' \dontrun{
#' kalbar_LC11 <- LUMENSR_example("kalbar_LC11.tif")
#' kalbar_LC11 <-   terra::rast(kalbar_LC11)
#' kalbar_LC11_att <- add_legend_to_categorical_raster(
#'   raster_file = kalbar_LC11,
#'   lookup_table = lc_lookup_klhk)
#' plot_categorical_raster(kalbar_LC11_att)
#' }
plot_categorical_raster <- function(raster_object) {
  ggplot() +
    geom_spatraster(data = raster_object) +
    tidyterra::scale_fill_hypso_d() +
    theme_bw() +
    labs(title = names(raster_object))
}

