#' Write SpatRaster Objects to a Directory
#'
#' This function writes any number of SpatRaster objects to a specified a directory.
#'
#' @param raster_objects Named list of SpatRaster objects to write.
#' @param a_dir directory for saving the SpatRaster objects.
#' @export
#' @importFrom terra writeRaster
#'
#' @examples
#' \dontrun{
#' library(terra)
#' # assuming rasters is a named list of SpatRaster objects
#' a_dir<- tempdir()
#' write_rasters_to_tempdir(rasters, a_dir)
#' }
write_rasters_to_adir<- function(raster_objects, a_dir) {
  # Initialize a list to store the paths of the written raster files
  raster_paths <- list()

  # Iterate over each SpatRaster object
  for (name in names(raster_objects)) {
    # Define the file path
    file_path <- file.path(a_dir, paste0(name, ".tif"))

    # Write the SpatRaster object to the a directory
    terra::writeRaster(raster_objects[[name]], file_path,  overwrite=TRUE)

    # Append the file path to the list of paths
    raster_paths[[name]] <- file_path
  }

  return(raster_paths)
}
