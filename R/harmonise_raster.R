#' Crop and harmonise predictors, such as climate and soil data
#'
#' This function takes a raster data and a polygon of the area of interest,
#' crops the raster data to the area of interest, and harmonizes the projection
#' and extent of the cropped raster data to match that of the polygon.
#'
#' @param dat_clim a spatRaster data
#' @param batas_kab the area of interest represented as an sf polygon
#'
#' @return a Spat raster object of the predictor with the same extent and area of batas_kab
#'         A SpatRaster object representing the cropped and harmonized predictor, with the same extent and area as the `batas_kab` object.
#' @export
#'
#' @importFrom terra rast crs crop resample project
#' @importFrom sf st_read st_transform st_crs
#'
#' @examples
#' worldclim_temp_indo <- LUMENSR_example("wc2.1_30s_bio_1_indo.tif")
#' temp_indo <-  terra::rast(worldclim_temp_indo)
#' harmonise_raster(dat_clim = temp_indo, batas_kab = ntt_admin)
harmonise_raster <- function(dat_clim, batas_kab) {
  # Check if spatial objects have the same projection; if not, transform polygon
  if (!identical(crs(dat_clim), st_crs(batas_kab))) {
    batas_kab_projected <- st_transform(batas_kab, crs = crs(dat_clim))
  }

  # Check if projection of raster is the same as polygon
  if (exists("batas_kab_projected")) {
    # When the raster has a different projection system as the polygon
    # Crop raster using polygon, project to the polygon's CRS, and resample to match the extent and resolution of the polygon
    dat_clim_cropped <- dat_clim %>%
      crop(batas_kab_projected) %>%
      project(crs(batas_kab))
  } else {
    # When the raster has the same projection system as the polygon

    # Crop raster using polygon and resample to match the extent and resolution of the polygon
    dat_clim_cropped <- dat_clim %>%
      crop(batas_kab)
  }

  return(dat_clim_cropped)
}
