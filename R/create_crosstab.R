#' Create Crosstab From Raster List
#'
#' This function takes a list of raster files, creates a stack, and returns a frequency table
#' (crosstab) of the stack. The frequency table is filtered to remove rows where the frequency is zero.
#'
#' @param raster_list A list of raster files to be processed.
#'
#' @return A data frame representing the crosstab of the input rasters.
#'
#' @importFrom terra rast crosstab
#' @importFrom purrr map
#' @importFrom dplyr %>%
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

  # Create a stack from the raster list
  landuse_stack <- terra::rast(raster_list)

  # Create a frequency table using crosstab and convert to a data frame
  crosstab_ <- terra::crosstab(landuse_stack) %>%
    as.data.frame()

  # Filter out rows where Freq is not equal to 0
  crosstab_ <- crosstab_[crosstab_$Freq != 0, ]

  # Return the result
  return(crosstab_)
}
