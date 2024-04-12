#' Create Crosstab From Raster List
#'
#' This function takes a list of raster files, creates a stack, and returns a frequency table
#' (crosstab) of the stack. The frequency table is filtered to remove rows where the frequency is zero.
#'
#' @param land_cover A list of 'SpatRaster' objects.
#' @param zone A SpatRaster' object of planning unit/zone
#'
#' @return A data frame representing the crosstab of the input rasters.
#'
#' @importFrom terra rast crosstab time
#' @importFrom dplyr arrange desc
#' @importFrom purrr is_vector
#' @importFrom magrittr %>%
#' @importFrom tidyr drop_na
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
#'   land_cover <- map(raster_files,
#'                             ~apply_lookup_table(raster_file = .x,
#'                                                 lookup_lc = subset_legend))
#'
#'   # Turn raster files into a frequency table
#'   crosstab_result <- create_crosstab(land_cover)
#' }
#'
#' @export
#'
create_crosstab <- function(land_cover, zone) {
  # Check if land_cover is a list of 'SpatRaster' objects
  if (!all(sapply(land_cover, function(x) class(x) == "SpatRaster"))) {
    stop("land_cover must be a list of 'SpatRaster' objects.")
  }

  # Check if all rasters in the list have levels (categories)
  has_levels <- sapply(land_cover, function(x) !is.null(terra::levels(x)))
  if(!all(has_levels)) {
    warning("Some rasters do not contain levels (categories).")
  }

  # Check if all SpatRaster objects have a time attribute
  all_times_present <- all(sapply(land_cover, function(x) !is.null(time(x))))
  if (!all_times_present) {
    stop("All SpatRaster objects must have a time attribute.")
  }

  # Rename layers based on year
  names(land_cover) <- as.character(time(land_cover))
  # Create a frequency table using crosstab and convert to a data frame
  # Check if 'zone' object exists
  # Check if 'zone' object exists
  if (!missing(zone)) {

    # Check if 'zone' and 'land_cover' have the same projection, extent and resolution
    if (compareGeom(land_cover, zone ,stopOnError = TRUE)) {

      crosstab_square <- terra::crosstab(c(land_cover, zone))

    } else {

      # Raise an error and stop execution
      stop("Zone exists but does not have the same projection, extent, and resolution as land_cover.")
    }
  } else {
    crosstab_square <- terra::crosstab(land_cover, useNA = TRUE, digits = 3)

  }

  crosstab_long <- crosstab_square %>%
    as.data.frame() %>%
    dplyr::arrange(desc(Freq)) %>% # order by descending Freq
    drop_na()

  # Rename columns to remove 'X' at the beginning
  names(crosstab_long) <- gsub("^X", "", names(crosstab_long))

  # Filter out rows where Freq is not equal to 0
  crosstab_long <- crosstab_long[crosstab_long$Freq != 0, ]
  # Return the result
  return(list(crosstab_square = crosstab_square, crosstab_long = crosstab_long))
}
