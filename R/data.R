#' Historical Temperature data for East Nusa Tenggara
#'
#' @description
#'  A subset of WorldClim version 2.1 climate data for 1970-2000. This version was released in January 2020; 30 seconds (~1 km2) spatial resolution.
#' A clipped raster dataset of the BIO1 = Annual Mean Temperature over East Nusa Tenggara.
#'
#' @format A RasterLayer object with:
#' \describe{
#'   \item{dimensions}{number of rows, columns, and layers}
#'   \item{resolution}{x and y resolution}
#'   \item{extent}{geographical extent}
#'   \item{crs}{coordinate reference system}
#'   \item{values}{raster values, in this case representing annual mean temperature}
#' }
#' @source <https://www.worldclim.org/data/worldclim21.html>
#"ntt_temp"


#' Historical Temperature data for Indonesia
#'
#' @description
#' A subset of WorldClim version 2.1 climate data for 1970-2000. This version was released in January 2020; 30 seconds (~1 km2) spatial resolution.
#' A clipped raster dataset of the BIO1 = Annual Mean Temperature over Indonesia.
#'
#' @format A RasterLayer object with:
#' \describe{
#'   \item{dimensions}{number of rows, columns, and layers}
#'   \item{resolution}{x and y resolution}
#'   \item{extent}{geographical extent}
#'   \item{crs}{coordinate reference system}
#'   \item{values}{raster values, in this case representing annual mean temperature}
#' }
#' @source <https://www.worldclim.org/data/worldclim21.html>
#"wc2.1_30s_bio_1_indo"



#' District boundaries of East Nusa Tenggara
#'
#' @description
#' A spatial dataset containing the district boundaries of East Nusa Tenggara.
#'
#' @format A SpatialPolygonsDataFrame object with 22 features and 2 fields:
#' \describe{
#'   \item{ID}{Country name}
#'   \item{Kabupaten}{District names of East Nusa Tenggara}
#' }
#' @source <https://data.humdata.org/dataset/cod-ab-idn>
"ntt_admin"

#' Land cover data of East Nusa Tenggara of 2020
#'
#' @description
#' KLHK land cover map of East Nusa Tenggara province for the year 2020
#'
#' @format A RasterLayer object of the land cover map.
#' @source Ministry of Forestry and Environment of Indonesia
#"NTT_LC20"

#' Land cover data of East Nusa Tenggara of 1990
#'
#' @description
#' KLHK land cover map of East Nusa Tenggara province for the year 1990.
#'
#' @format A RasterLayer object of the land cover map.
#' @source Ministry of Forestry and Environment of Indonesia
#"NTT_LC90"

#' Land cover data of West Kalimantan of 2011
#'
#' @description
#' KLHK land cover map of West Kalimantan province for the year 2011.
#'
#' @format A RasterLayer object of the land cover map.
#' @source Ministry of Forestry and Environment of Indonesia
#"kalbar_LC11"

#' Land cover data of West Kalimantan of 2015
#'
#' @description
#' KLHK land cover map of West Kalimantan province for the year 2015.
#'
#' @format A RasterLayer object of the land cover map.
#' @source Ministry of Forestry and Environment of Indonesia
#"kalbar_LC15"

#' Land cover data of West Kalimantan of 2020
#'
#' @description
#' KLHK land cover map of West Kalimantan province for the year 2020.
#'
#' @format A RasterLayer object of the land cover map.
#' @source Ministry of Forestry and Environment of Indonesia
#"kalbar_LC20"

#' The Indonesian Ministry of Environment and Forestry (KLHK) Land Cover Lookup Table
#'
#' @description
#' A lookup table that maps land cover codes to land cover descriptions for the Indonesian Ministry of Environment and Forestry (KLHK).
#'
#' @format
#' A data frame with 23 rows and 2 columns:
#' \describe{
#'   \item{Value}{The land cover code}
#'   \item{PL20}{The land cover description}
#' }
#' @source The data was obtained from the Indonesian Ministry of Environment and Forestry (KLHK).
#'
#' @examples
#' data(lc_lookup_klhk)
#' head(lc_lookup_klhk)
"lc_lookup_klhk"

#' Reclassified Land Cover Lookup Table from the Indonesian Ministry of Environment and Forestry (KLHK)
#'
#' @description
#' This lookup table relates reclassified land cover codes to their respective descriptions,
#' as defined by the Indonesian Ministry of Environment and Forestry (KLHK). The original land cover
#' values have been replaced with a sequence of numbers from 1 to 23.
#'
#' @format
#' A data frame with 23 rows and 2 columns:
#' \describe{
#'   \item{Value}{Reclassified land cover codes ranging from 1 to 23}
#'   \item{PL20}{Descriptions for each corresponding land cover code}
#'   \item{color_pallette}{hex color codes of predefined colour for each land cover class}
#' }
#'
#' @source
#' The data was obtained and adapted from the Indonesian Ministry of Environment and Forestry (KLHK).
#'
#' @examples
#' data(lc_lookup_klhk_sequence)
#' head(lc_lookup_klhk_sequence)
"lc_lookup_klhk_sequence"



#' Cross Tabulation of Land Cover Classes
#'
#' @description
#' A data frame containing the result of a cross tabulation between two land cover classes
#' from Kalimantan Barat, Indonesia. The data frame contains the names of each class and
#' their frequency.
#'
#' @format
#' A data frame with 281 rows and 3 columns:
#' \describe{
#'   \item{kalbar_LC11}{The land cover class for the year 2011. This is a factor with 20 levels.}
#'   \item{kalbar_LC20}{The land cover class for the year 2020. This is a factor with 19 levels.}
#'   \item{Freq}{The frequency count of each cross tabulation between `kalbar_LC11` and `kalbar_LC20`.}
#' }
#' @source The data is a result of a cross tabulation from a land cover change analysis in Kalimantan Barat, Indonesia.
#'
#' @examples
#' data(crosstab_result)
#' head(crosstab_result)
"crosstab_result"

#' District boundaries of East Nusa Tenggara in spatraster format
#'
#' @description
#' A data frame containing the district boundaries of East Nusa Tenggara.
#'
#' @format A data frame with 22 features and 2 fields:
#' \describe{
#'   \item{ID}{Country name}
#'   \item{Kabupaten}{District names of East Nusa Tenggara}
#' }
"ntt_admin_lookup"
