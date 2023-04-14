#' Visualize Temperature Map
#'
#' This function generates a ggplot object that displays temperature raster data
#' and boundary polygon data on a map. The color scale of the temperature data is
#' customized and the legend is labeled in degrees Celsius.
#'
#' @param temperature_data A spatial raster object that contains temperature data.
#' @param boundary_data A spatial polygon object that contains boundary data.
#' @param boundary_data_column column names relevant for mapping
#' @param temp_limit temperature range in degree celcius, default is c(10,35)
#'
#' @return A ggplot object that displays the temperature map.
#'
#' @export
#'
#' @importFrom scales label_number
#' @importFrom terra rast
#' @importFrom sf st_read
#' @importFrom ggplot2 ggplot theme_bw labs element_rect element_blank geom_sf aes theme
#' @importFrom tidyterra geom_spatraster scale_fill_whitebox_c
#'
#' @examples
#' library(terra)
#' library(sf)
#' temp_data <- rast("inst/extdata/east_nusa_tenggara/climate/wc2.1_30s_bio_1.tif")
#' boundary_data <- st_read("inst/extdata/east_nusa_tenggara/admin/batas_adm.shp")
#' vis_map_temperature(temperature_data = temp_data, boundary_data = boundary_data)

vis_map_temperature <- function(temperature_data,
                                boundary_data,
                                boundary_data_column="Kabupaten",
                                temp_limit = c(10,35)) {
  #Generate a ggplot object with temperature raster data

  map_temp_ <- ggplot() +
    geom_spatraster(data = temperature_data) + # add temperature raster data to the plot
    scale_fill_whitebox_c( # customize the color scale of the temperature data
      palette = "muted",
     # labels = label_number(suffix = "\u00B0"),
      limit = temp_limit
    ) +
    theme_bw() +
    geom_sf( # add boundary polygon data to the plot
      data = boundary_data,
      aes(fill = {{boundary_data_column}}),
      inherit.aes = FALSE,
      fill = NA
    ) +
    labs(fill = "Temperatur \nrata-rata (\u00B0C)") +
    theme(
      panel.background = element_rect(fill = 'transparent'),
      plot.background = element_rect(fill = 'transparent', color = NA),
      # panel.grid.major = element_blank(),
      # panel.grid.minor = element_blank(),
      legend.background = element_rect(fill = 'transparent'),
      legend.box.background = element_rect(fill = 'transparent')
    )

  #Return the ggplot object
  return(map_temp_)
}
