#' Rasterize an sf MULTIPOLYGON object
#'
#' This function rasterizes an sf MULTIPOLYGON object to a SpatRaster object. The function also retains
#' an attribute table from the sf object, by assigning categorical ID values to the raster values.
#' The rasterized SpatRaster object will also contain a legend derived from the attribute table of the sf object.
#'
#' @param sf_object An sf MULTIPOLYGON object. It must contain an attribute table, with at least one categorical ID (numeric).
#' @param raster_res A numeric vector specifying the resolution of the raster. Default is c(100,100).
#' @param field A character string specifying the field name to be used for rasterization from the sf object. Default is "ID".
#' @return A SpatRaster object that is a rasterized version of the input sf object, with a legend derived from the attribute table of the sf object.
#' @importFrom sf st_drop_geometry st_geometry_type st_crs
#' @importFrom terra vect ext rast rasterize levels
#' @export
#' @examples
#' rasterise_multipolygon(sf_object = ntt_admin, raster_res = c(100,100), field = "ID")
rasterise_multipolygon <- function(sf_object, raster_res = c(100,100), field = "ID"){

  # Error checking
  if (!inherits(sf_object, "sf")) stop("sf_object must be an sf object.")
  if (!all(sf::st_geometry_type(sf_object) == "MULTIPOLYGON")) stop("All features in sf_object must be MULTIPOLYGONs.")  # Check if sf_object has UTM projection
  if (!grepl("\\+proj=utm", st_crs(sf_object)$proj4string)) stop("sf_object must have UTM projection system.")
  if (is.null(sf::st_drop_geometry(sf_object)) || !(field %in% names(sf::st_drop_geometry(sf_object)))) stop("sf_object must contain an attribute table with at least one numeric/factor column.")
  if (!is.numeric(sf_object[[field]]) && !is.factor(sf_object[[field]])) stop("The field must be numeric or a factor.")

  # Convert the sf object to a SpatVector
  spatvect <- terra::vect(sf_object)

  # Define the extent based on the SpatVector
  raster_extent <- terra::ext(spatvect)

  # Create an empty SpatRaster based on the extent, resolution, and CRS
  raster_template <- terra::rast(raster_extent, resolution = raster_res, crs = terra::crs(spatvect))

  # Rasterize the SpatVector based on the SpatRaster template
  # Specify the field in the rasterize function
  rasterised_spatraster <- terra::rasterize(spatvect, raster_template, field = field)

  # Convert the 'Kabupaten' column of the sf_object to a lookup_table
  lookup_table <- sf::st_drop_geometry(sf_object)

  # Add legend to the rasterized SpatRaster using the lookup_table
  levels(rasterised_spatraster) <- lookup_table

  # Return the rasterized SpatRaster with legend
  return(rasterised_spatraster)
}
