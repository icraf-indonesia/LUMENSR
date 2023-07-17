#' Assign a time period to a SpatRaster object
#'
#' @param raster_layer A SpatRaster object
#' @param year_ A string representing a year
#'
#' @return The original SpatRaster object, with an assigned time period
#' @export
#'
#' @examples
#' # Load terra package
#' library(terra)
#' # Create example SpatRaster
#' r <- rast(nrow=10, ncol=10)
#' r[] <- 1:ncell(r)
#' s <- stack(r, r*2, r^2)
#' # Assign a time period
#' s <- assign_time_period(s, "2023")
#'
#' @importFrom terra SpatRaster

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
  time(raster_layer) <- as.Date(paste0(year_, "-01-01"))

  return(raster_layer)
}
