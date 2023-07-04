#' Add legend to categorical raster
#'
#' This function adds a legend to a categorical raster file, often containing information about land cover or planning units.
#'
#' @param raster_file A categorical raster file (an object of class `SpatRaster`)
#' @param lookup_table A corresponding lookup table of descriptions for each class category
#' @return A raster file that contains descriptions for each class category
#' @importFrom terra levels
#' @export
#'
#' @examples
#' \dontrun{
#' add_legend_to_categorical_raster(raster_file = kalbar_11, lookup_table = lc_lookup_klhk) %>% plot()
#' }
add_legend_to_categorical_raster <- function(raster_file, lookup_table){
  name_rast <-names(raster_file)

  levels(raster_file) <- lookup_table
  raster_file <- setNames(raster_file,name_rast)
  return(raster_file)
}
