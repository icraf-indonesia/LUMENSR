#' Calculate Resolution Conversion Factor To Hectares
#'
#' This function calculates the conversion factor of a raster map resolution to hectares,
#' depending on the coordinate reference system (CRS) of the raster.
#' Raster maps with projection in meter or degree units are supported.
#'
#' @param raster_input A terra::SpatRaster object.
#' @return A numerical value representing the conversion factor of the raster map resolution to hectares.
#' @importFrom terra crs res
#' @export
calc_res_conv_factor_to_ha <- function(raster_input) {

  crs <- terra::crs(raster_input, proj=TRUE) # Get the CRS of the raster

  # Check if the CRS is in meter unit
  if (grepl("+units=m", crs)) {
    message("Raster map has a projection in metre unit.")
    conversion_factor <- terra::res(raster_input)[1] * terra::res(raster_input)[2] / 10000
    message(paste("Raster map has ", conversion_factor, " Ha spatial resolution. Pre-QuES will automatically generate data in Ha unit."))

    # Check if the CRS is in degree unit
  } else if (grepl("+proj=longlat", crs)) {
    message("Raster map has a projection in degree unit.")
    conversion_factor <- terra::res(raster_input)[1] * terra::res(raster_input)[2] * (111319.9 ^ 2) / 10000
    message(paste("Raster map has ", conversion_factor, " Ha spatial resolution. Pre-QuES will automatically generate data in Ha unit."))

    # If the CRS is neither in meter nor degree unit, throw an error
  } else {
    stop("Projection of the raster map is unknown")
  }

  return(conversion_factor)
}
