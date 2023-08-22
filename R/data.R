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

#' PreQUES Land Use Change Analysis Report
#'
#' @description
#' `PreQUES_report.qmd` is a R Markdown document that generates a report for analyzing land use change.
#' It follows the Quick Ecosystem Service Assessment (Ques) methodology and is used to identify and evaluate the impact of
#' land use change on various ecosystem services.
#'
#' @format
#' A R Markdown (qmd) file that can be rendered into a variety of formats including HTML, PDF, and Word.
#'
#' @source
#' The analysis methodology is based on the Quantification of Environmental Services module.
#"PreQUES_report.qmd"

#' Analysis Per Planning Unit Child Document
#'
#' @description
#' `quespre_by_pu.qmd` is a knitr child document used in the generation of land use change analysis reports.
#' This child document is used to perform analyses on a per planning unit basis, thus providing more granular results.
#'
#' @format
#' A R Markdown (qmd) child file that is incorporated into a main R Markdown file via the `child` parameter in a code chunk.
#'
#' @source
#' This child document is a part of the Quantification of Environmental Services module.
#"quespre_by_pu.qmd"



#' Lookup Table for Reclassified Trajectories
#'
#' @description
#' This lookup table maps land cover codes to their respective descriptions and
#' trajectory classes. The original land cover values have been replaced with a sequence
#' of numbers from 1 to 23.
#'
#' @format
#' A data frame with 23 rows and 4 columns:
#' \describe{
#'   \item{Value}{Reclassified land cover codes ranging from 1 to 23}
#'   \item{PL20}{Descriptions for each corresponding land cover code in Bahasa Indonesia}
#'   \item{traj_id}{Trajectory ID for each land cover code}
#'   \item{trajectory}{English descriptions for each corresponding trajectory ID}
#' }
#'
#' @source
#' The data was adapted from the Indonesian Ministry of Environment and
#' Forestry (KLHK).
#'
#' @name lookup_traj_reclass
#' @docType data
"lookup_traj_reclass"

#' Lookup Table for Reclassified Trajectories
#'
#' @description
#' This lookup table maps land cover codes to their respective descriptions and
#' trajectory classes. The original land cover values have been replaced with a sequence
#' of numbers from 1 to 23.
#'
#' @format
#' A data frame with 23 rows and 4 columns:
#' \describe{
#'   \item{Value}{Reclassified land cover codes ranging from 1 to 23}
#'   \item{PL20}{Descriptions for each corresponding land cover code in Bahasa Indonesia}
#'   \item{traj_id}{Trajectory ID for each land cover code}
#'   \item{trajectory}{English descriptions for each corresponding trajectory ID}
#' }
#'
#' @source
#' The data was adapted from the Indonesian Ministry of Environment and
#' Forestry (KLHK).
#'
#' @name lookup_traj_reclass
#' @docType data
"lookup_traj_reclass"

#' Lookup Table for Major Land Use Types
#'
#' @description
#' This lookup table represents major land use types that are part of the land use change
#' trajectory analysis. It is used to reclassify a land cover map, mapping specific trajectory IDs
#' to their respective descriptions.
#'
#' @format
#' A tibble with 8 rows and 2 columns:
#' \describe{
#'   \item{traj_id}{Trajectory ID for each major land use type, ranging from 1 to 8}
#'   \item{trajectory}{English descriptions corresponding to each trajectory ID, representing different land use types}
#' }
#'
#' @source
#' The table may be part of a larger data set or analysis within your organization or project. Include additional source information as needed.
#'
#' @name driluc_traj_lookup
#' @docType data
"driluc_traj_lookup"




