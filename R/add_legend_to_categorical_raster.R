#' Add legend to categorical raster
#'
#' This function adds a legend to a categorical raster file, often containing information about land cover or planning units.
#'
#' @param raster_file A categorical raster file (an object of class `SpatRaster`)
#' @param lookup_table A corresponding lookup table of descriptions for each class category
#' @param year An optional year to be associated with the raster file
#'
#' @return A raster file that contains descriptions for each class category
#' @importFrom terra levels freq time names
#' @importFrom stats setNames
#' @export
#'
#' @examples
#' \dontrun{
#' add_legend_to_categorical_raster(raster_file = kalbar_11,
#'               lookup_table = lc_lookup_klhk,
#'               year = 2011) %>%
#'               plot()
#' }

add_legend_to_categorical_raster <- function(raster_file, lookup_table, year = NULL) {
  # Check if raster_file is a SpatRaster object
  if (!inherits(raster_file, "SpatRaster")) {
    stop("raster_file should be a SpatRaster object")
  }

  # Check if lookup_table is a data frame
  if (!is.data.frame(lookup_table)) {
    stop("lookup_table should be a data frame")
  }

  # Check if the first column of lookup_table is numeric or convertible to numeric
  first_column <- lookup_table[[1]]
  if (!is.numeric(first_column) && any(is.na(as.numeric(first_column)))) {
    stop("The first column of lookup_table should be numeric or convertible to numeric")
  }

  # Check if year is a numeric value or NULL, and if it consists of 4 digits
  if (!is.null(year) && (!is.numeric(year) || nchar(as.character(year)) != 4)) {
    stop("year should be a numeric value consisting of 4 digits")
  }

  # Filter lookup_table to only include values present in raster_file
  lookup_table <- lookup_table[lookup_table[[1]] %in% terra::freq(raster_file)[["value"]], ]

  # Convert lookup_table into a data frame
  lookup_table <- data.frame(lookup_table)

  # Convert the first column to numeric if it is not already
  if (!is.numeric(first_column)) {
    lookup_table[[1]] <- as.numeric(first_column)
  }

  # Get the names of raster_file
  name_rast <- names(raster_file)

  # Set the levels of raster_file to be lookup_table
  levels(raster_file) <- lookup_table

  # Set the names of raster_file
  raster_file <- setNames(raster_file, name_rast)

  # Set the year if year is not NULL
  if (!is.null(year)) {
    terra::time(raster_file, tstep="years") <- year
  }

  # Return the modified raster_file
  return(raster_file)
}
