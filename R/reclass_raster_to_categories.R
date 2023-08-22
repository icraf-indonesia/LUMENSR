#' Reclassify a Raster to Categories
#'
#' This function reclassifies a raster using a provided reclassification table.
#'
#' @param raster_map A raster object to be reclassified.
#' @param reclass_table A data frame containing the reclassification rules. The first column must be the existing
#' values (ID_check) and the second column should be the new values (reclass_mat).
#'
#' @return
#' A reclassified factor raster.
#'
#' @examples
#' \dontrun{
#' # assuming we have a raster object "my_raster" and a reclassification table "my_table"
#' my_reclassed_raster <- reclass_raster_to_categories(my_raster, my_table)
#' }
#'
#' @export
#' @importFrom terra classify droplevels as.factor cats
#' @importFrom dplyr select_if rename left_join select
#' @importFrom purrr pluck
#'
reclass_raster_to_categories <- function(raster_map, reclass_table){
  # Retrieve unique IDs from the raster and rename column to 'Value'
  ID_check <- terra::droplevels(raster_map) |> terra::cats() |> pluck(1) |> select(1)

  colnames(reclass_table)[1] <- colnames(ID_check)

  # Join the reclassification table with the ID_check,
  # keep only the numeric columns and convert to matrix
  reclass_mat <- left_join(ID_check, reclass_table, by=colnames(ID_check)) %>% select_if(is.numeric) %>% as.matrix()

  # Reclassify the raster using the reclassification matrix and convert to factor
  raster_map_reclass <- classify(raster_map, reclass_mat) %>% as.factor()

  return(raster_map_reclass)
}
