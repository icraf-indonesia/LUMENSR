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
#'   \item{color_palette}{hex color codes of predefined colour for each land cover class}
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

#' Lookup Table for Land Cover Trajectories
#'
#' @description
#' The `lut_trajectory` tibble contains a lookup table that maps trajectory IDs to their
#' corresponding land cover trajectory descriptions. This lookup table is used to assign
#' meaningful labels to the land cover change trajectories identified in the analysis.
#'
#' @format
#' A tibble with 8 rows and 2 columns:
#' \describe{
#'   \item{traj_id}{The unique identifier for each land cover trajectory (integer).}
#'   \item{trajectory}{The description of the land cover trajectory corresponding to each
#'   `traj_id` (character).}
#' }
#'
#' @details
#' The land cover trajectories represented in this lookup table are:
#' \enumerate{
#'   \item Undisturbed forest: Areas that have remained as undisturbed forest throughout
#'   the analysis period.
#'   \item Logged-over forest: Forest areas that have been subject to logging activities.
#'   \item Monoculture tree-based plantation: Plantations that consist of a single tree
#'   species, typically grown for commercial purposes.
#'   \item Shrub, grass, and cleared land: Areas covered by shrubs, grasslands, or land
#'   that has been cleared of its previous vegetation.
#'   \item Agriculture/annual crop: Land used for agricultural purposes, particularly for
#'   growing annual crops.
#'   \item Mixed tree-based plantation: Plantations that consist of multiple tree species,
#'   often with a mix of commercial and native species.
#'   \item Others: Land cover types that do not fall into any of the other defined
#'   categories.
#'   \item Settlement and built-up area: Areas that have been developed for human
#'   settlement, including urban and rural built-up areas.
#' }
#'
#' This lookup table is typically used in conjunction with the land cover change analysis
#' functions in the LUMENSR package. It helps in assigning meaningful labels to the
#' identified land cover trajectories, making the results more interpretable.
#'
#' @source LUMENSR package
#'
#' @name lut_trajectory
#' @docType data
"lut_trajectory"

#' Lookup Table for Land Cover Change Trajectories
#'
#' @description
#' The `lookup_trajectory_complete` data frame provides a comprehensive lookup table for
#' land cover change trajectories. It maps the combinations of initial and final land
#' cover classes to specific trajectory IDs and defines the corresponding trajectory
#' descriptions.
#'
#' @format
#' A data frame with 64 rows and 7 columns:
#' \describe{
#'   \item{ID_1}{Numeric identifier for the initial land cover class.}
#'   \item{ID_2}{Numeric identifier for the final land cover class.}
#'   \item{CLASS_1}{Description of the initial land cover class.}
#'   \item{CLASS_2}{Description of the final land cover class.}
#'   \item{ID_traj}{Unique identifier for each land cover change trajectory, formed by
#'   combining ID_1 and ID_2 with an underscore.}
#'   \item{trajectory}{Detailed description of each land cover change trajectory.}
#'   \item{def}{Simplified definition or category of each land cover change trajectory.}
#' }
#'
#' @details
#' The `lookup_trajectory_complete` data frame provides a mapping of land
#' cover change trajectories. It considers all possible combinations of initial and final
#' land cover classes and assigns a unique trajectory ID to each combination. The data
#' frame also includes detailed descriptions and simplified definitions for each
#' trajectory.
#'
#' The land cover classes considered in this lookup table are:
#' \enumerate{
#'   \item Undisturbed forest
#'   \item Logged-over forest
#'   \item Monoculture tree-based plantation
#'   \item Shrub, grass, and cleared land
#'   \item Agriculture/annual crop
#'   \item Mixed tree-based plantation
#'   \item Others
#'   \item Settlement and built-up area
#' }
#'
#' The `ID_traj` column is formed by concatenating the `ID_1` and `ID_2` values with an
#' underscore, providing a unique identifier for each land cover change trajectory.
#'
#' The `trajectory` column provides a detailed description of each land cover change
#' trajectory, indicating the specific transition from the initial land cover class to
#' the final land cover class.
#'
#' The `def` column provides a simplified definition or category for each land cover
#' change trajectory, such as "Stable forest," "Reforestation," "Deforestation," or
#' "Other."
#'
#' @source LUMENSR package
#'
#' @examples
#' # View the first few rows of the lookup table
#' head(lookup_trajectory_complete)
#'
#' # Filter the lookup table for a specific initial land cover class
#' subset(lookup_trajectory_complete, ID_1 == 1)
#'
#' @name lookup_trajectory_complete
#' @docType data
"lookup_trajectory_complete"
