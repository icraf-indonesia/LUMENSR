#' Create Crosstab From Raster List
#'
#' This function takes a list of raster files, creates a stack, and returns a frequency table
#' (crosstab) of the stack. The frequency table is filtered to remove rows where the frequency is zero.
#'
#' @param raster_list A list of 'SpatRaster' objects.
#'
#' @return A data frame representing the crosstab of the input rasters.
#'
#' @importFrom terra rast crosstab
#' @importFrom dplyr arrange desc
#' @importFrom purrr is_vector
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#'   # Read in the legend for raster data
#'   subset_legend <- LUMENSR::lc_lookup_klhk
#'
#'   # Read raster files
#'   raster_files <- c("kalbar_LC11.tif", "kalbar_LC15.tif", "kalbar_LC20.tif") %>%
#'     map(LUMENSR_example) %>%
#'     map(rast)
#'
#'   # Loop through raster files
#'   raster_list <- map(raster_files,
#'                             ~apply_lookup_table(raster_file = .x,
#'                                                 lookup_lc = subset_legend))
#'
#'   # Turn raster files into a frequency table
#'   crosstab_result <- create_crosstab(raster_list)
#' }
#'
#' @export
#'
create_crosstab <- function(raster_list) {
  # Check if raster_list is a list of 'SpatRaster' objects
  if (!all(sapply(raster_list, function(x) class(x) == "SpatRaster"))) {
    stop("raster_list must be a list of 'SpatRaster' objects.")
  }

  # Check if all rasters in the list have levels (categories)
  has_levels <- sapply(raster_list, function(x) !is.null(terra::levels(x)))
  if(!all(has_levels)) {
    warning("Some rasters do not contain levels (categories).")
  }

  # Create a stack from the raster list
  landuse_stack <- terra::rast(raster_list)

  # Create a frequency table using crosstab and convert to a data frame
  crosstab_ <- terra::crosstab(landuse_stack) %>%
    as.data.frame() %>%
    dplyr::arrange(desc(Freq)) # order by descending Freq

  # Filter out rows where Freq is not equal to 0
  crosstab_ <- crosstab_[crosstab_$Freq != 0, ]

  # Return the result
  return(crosstab_)
}
