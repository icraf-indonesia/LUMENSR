#' Calculate land cover frequency for multiple raster layers
#'
#' This function takes multiple raster layers as input and returns a
#' frequency table for each layer, sorted by the count of the last raster layer in descending order.
#' An input of a terra's rast object is allowed.
#'
#' @param raster_list list of raster layers or a single raster layer.
#'
#' @return A dataframe of frequency tables.
#'
#' @importFrom terra compareGeom freq levels
#' @importFrom dplyr left_join select arrange desc rename
#' @importFrom purrr map
#'
#' @examples
#' \dontrun{
#' library(tidyverse)
#'
#' # Create a vector of raster file names
#' lc_maps <- c("kalbar_LC11.tif", "kalbar_LC20.tif") %>%
#'   # Apply LUMENSR_example function to each file in the vector
#'   map(~ LUMENSR_example(.x)) %>%
#'   # Convert each file to a raster object
#'   map(~ terra::rast(.x)) %>%
#'   # Add a legend to each raster object using a provided lookup table
#'   map(~ add_legend_to_categorical_raster(raster_file = .x, lookup_table = lc_lookup_klhk))
#'
#' # Calculate the frequency table for each raster object in the list
#' freq_table <- calc_lc_freq(lc_maps)
#'
#' # Print the resulting frequency table
#' print(freq_table)
#' }
calc_lc_freq <- function(raster_list) {
  # Check if input is a single raster layer
  if (class(raster_list)[1] == "SpatRaster") {
    raster_list <- list(raster_list)
  } else if (!is.list(raster_list)) {
    stop("Input must be a list of raster layers or a single raster layer")
  }

  # Check if all rasters have the same extent and CRS
  if (length(raster_list) > 1) {
    for (i in 2:length(raster_list)) {
      if (!terra::compareGeom(raster_list[[1]], raster_list[[i]], stopiffalse = FALSE)) {
        stop("All rasters must have the same extent and projection system")
      }
    }
  }

  # Prepare an empty list to store frequency tables
  freq_tables <- list()

  # Loop over all raster layers in the list
  for (i in 1:length(raster_list)) {
    # Check if raster has attributes
    if (is.null(terra::levels(raster_list[[i]]))) {
      warning(paste0("Raster ", i, " has no attributes"))
    }

    # Get frequency table
    freq <- terra::freq(raster_list[[i]])

    # Rename 'count' column to be specific for each raster
    names(freq)[names(freq) == "count"] <- paste0(names(raster_list[[i]]), "_count")

    # Store frequency table in the list
    freq_tables[[i]] <- freq
  }

  # Combine frequency tables into one dataframe
  freq_df <- freq_tables[[1]]
  if (length(freq_tables) > 1) {
    for (i in 2:length(freq_tables)) {
      freq_df <- dplyr::left_join(freq_df, freq_tables[[i]], by = c("layer", "value"))
    }
    freq_df <- dplyr::select(freq_df, -layer)
  }

  # Sort by the count of the last raster layer in descending order
  freq_df <- dplyr::arrange(freq_df, dplyr::desc(freq_df[[ncol(freq_df)]]))
  freq_df <- dplyr::rename(freq_df, `Jenis tutupan lahan` = value)

  return(freq_df)
}
