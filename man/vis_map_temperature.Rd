% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vis_map_temperature.R
\name{vis_map_temperature}
\alias{vis_map_temperature}
\title{Visualize Temperature Map}
\usage{
vis_map_temperature(
  temperature_data,
  boundary_data,
  boundary_data_column = "Kabupaten",
  temp_limit = c(10, 35)
)
}
\arguments{
\item{temperature_data}{A spatial raster object that contains temperature data.}

\item{boundary_data}{A spatial polygon object that contains boundary data.}

\item{boundary_data_column}{column names relevant for mapping}

\item{temp_limit}{temperature range in degree celcius, default is c(10,35)}
}
\value{
A ggplot object that displays the temperature map.
}
\description{
This function generates a ggplot object that displays temperature raster data
and boundary polygon data on a map. The color scale of the temperature data is
customized and the legend is labeled in degrees Celsius.
}
\examples{
ntt_temp_path <- LUMENSR_example("ntt_temp.tif")
ntt_temp <-  terra::rast(ntt_temp_path)
vis_map_temperature(temperature_data = ntt_temp, boundary_data = ntt_admin)
}
