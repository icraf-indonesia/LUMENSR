#' Apply legend and color table to raster files
#'
#' @param raster_file A raster file
#' @param lookup_lc A lookup table that maps raster values to legend and colors
#'
#' @return A raster file with the specified  legend and color table
#'
#' @author Dony Indiarto
#'
#' @export
#' @import terra
#' @importFrom grDevices col2rgb rainbow
#' @importFrom stats setNames
#' @importFrom dplyr left_join select
#'
#' @examples
#'
#' # Load the LUMENSR package
#' library(LUMENSR)
#' library(terra)
#'
#' # Load the 2011 land cover raster for the Kalbar region
#' kalbar_2011 <- rast(LUMENSR_example("kalbar_LC11.tif")) %>% classify(cbind(0,NA))
#'
#' # apply a lookup table into a table
#' kalbar_2011_legend <- apply_lookup_table(kalbar_2011, lc_lookup_klhk)
#'
#' # Plot the classified raster
#' plot(kalbar_2011_legend)
apply_lookup_table <- function(raster_file, lookup_lc) {
  # Get the original name of the raster file
  og_raster_name <- names(raster_file)

  # Generate a color table for the raster data
  # n_classes <- nrow(lookup_lc)
  # coltb <- data.frame(t(col2rgb(rainbow(n_classes, end=.9), alpha=TRUE)))
  # Apply the lookup table to the raster data
  raster_file <-as.factor(raster_file)

  # Join with the lookup table
  new_levels <- levels(raster_file)[[1]] %>%
    left_join(lookup_lc, by = c("ID" = "Value")) %>%
    select(-"label")

  # Replace the levels in the raster with the new levels
  levels(raster_file)[[1]] <- new_levels
  #coltab(raster_file) <- coltb

  # Set the original name of the raster file
  names(raster_file) <- og_raster_name

  # Return the classified raster file
  raster_file
}
