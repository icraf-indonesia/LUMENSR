#' Assign a time period to a SpatRaster object
#'
#' @param raster_layer A SpatRaster object
#' @param year_ A string representing a year
#' @importFrom terra time
#' @return The original SpatRaster object, with an assigned time period
#' @export
#'
#' @examples
#' # Load terra package
#' library(terra)
#' # Create example SpatRaster
#' r <- rast(nrow=10, ncol=10)
#' r[] <- 1:ncell(r)
#' # Assign a time period
#' assign_time_period(r, "2023")

assign_time_period <- function(raster_layer, year_) {
  # Check if raster_layer is of class 'SpatRaster'
  if(!inherits(raster_layer, "SpatRaster")) {
    stop("raster_layer must be of class 'SpatRaster'")
  }

  # Check if year_ is a string of four digits
  if(!is.character(year_) || !nchar(year_) == 4 || !grepl("^\\d{4}$", year_)) {
    stop("year_ must be a string representing a 4-digit year")
  }

  # Assign time period
  terra::time(raster_layer, tstep="years") <- as.Date(paste0(year_, "-01-01"))

  return(raster_layer)
}
