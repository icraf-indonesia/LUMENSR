#' Create lookup table for land cover trajectories
#'
#' This function generates a tibble that maps reclassify IDs to their
#' corresponding land cover new class names.
#'
#' @return A tibble with two columns: `ID` (the ID of each land cover
#'   classification) and `class` (the name of each land cover class).
#' @importFrom tibble tibble
#' @export
#'
#' @examples
#' \dontrun{
#' lut_class <- create_lut_reclass()
#' head(lut_reclass)
#' }
create_lut_reclass <- function() {
  lut_reclass <- tibble(
    ID = 1:8,
    class = c(
      "Undisturbed forest",
      "Logged-over forest",
      "Monoculture tree-based plantation",
      "Shrub, grass, and cleared land",
      "Agriculture/annual crop",
      "Mixed tree-based plantation",
      "Others",
      "Settlement and built-up area"
    )
  )
  return(lut_reclass)
}

#' Generate Combinations of Trajectory IDs
#'
#' This function generates combinations of trajectory IDs from a lookup table and creates a new ID column.
#'
#' @param df A data frame containing trajectory IDs and classes.
#' @return A data frame with combinations of trajectory IDs and classes.
#' @importFrom dplyr left_join rename mutate distinct
#' @examples
#' \dontrun{
#' lut_class <- create_lut_reclass()
#' generate_combinations(new_traj_class)
#' }
generate_combinations <- function(df) {

  # Generate combinations of traj_id from lut_trajectory for both ID_1 and ID_2
  combinations <- df[[1]] %>%
    expand.grid(ID_1 = ., ID_2 = .) %>%

    # Perform a left_join to bring in the trajectories from lut_trajectory as CLASS_1
    # Rename the resulting trajectory column to CLASS_1
    left_join(df, by = c("ID_1" = "ID")) %>%
    rename(CLASS_1 = class) %>%

    # Perform a left_join to bring in the trajectories from lut_trajectory as CLASS_2
    # Rename the resulting trajectory column to CLASS_2
    left_join(df, by = c("ID_2" = "ID")) %>%
    rename(CLASS_2 = class) %>%

    # Create a new ID_traj column by concatenating ID_1 and ID_2
    mutate(ID_traj = paste(ID_1, ID_2, sep="_")) |> distinct()

  return(combinations)
}



#' Create lookup table for land cover change trajectories
#'
#' This function generates a tibble that maps trajectory IDs to their
#' corresponding land cover trajectory names and definitions.
#'
#' @return A tibble with three columns: `ID` (the ID of each land cover
#'   trajectory), `trajectory` (the name of each land cover trajectory),
#'   and `def` (the definition of each land cover trajectory).
#' @importFrom tibble tribble
#' @export
#'
#' @examples
#' traj_lookup <- create_traj_lookup()
#' head(traj_lookup)
create_traj_lookup <- function() {
  traj_lookup <- tribble(
    ~ID,                      ~trajectory,  ~def,

    "1_1",  "Stable natural forest", "Stable forest",
    "2_2",  "Stable natural forest", "Stable forest",


    "1_2", "Loss to logged-over forest", "Forest degradation",


    "2_1", "Recovery to forest", "Reforestation",
    "3_1", "Recovery to forest", "Reforestation",
    "4_1", "Recovery to forest", "Reforestation",
    "5_1", "Recovery to forest", "Reforestation",
    "6_1", "Recovery to forest", "Reforestation",
    "7_1", "Recovery to forest", "Reforestation",
    "8_1", "Recovery to forest", "Reforestation",
    "3_2", "Recovery to forest", "Reforestation",
    "4_2", "Recovery to forest", "Reforestation",
    "5_2", "Recovery to forest", "Reforestation",
    "6_2", "Recovery to forest", "Reforestation",
    "7_2", "Recovery to forest", "Reforestation",
    "8_2", "Recovery to forest", "Reforestation",

    "3_6", "Recovery to agroforest", "Other",
    "4_6", "Recovery to agroforest", "Other",
    "5_6", "Recovery to agroforest", "Other",
    "7_6", "Recovery to agroforest", "Other",
    "8_6", "Recovery to agroforest", "Other",


    "4_3", "Recovery to tree cropping", "Other",
    "5_3", "Recovery to tree cropping", "Other",
    "7_3", "Recovery to tree cropping", "Other",
    "8_3", "Recovery to tree cropping", "Other",


    "1_5", "Loss to cropland", "Deforestation",
    "2_5", "Loss to cropland", "Deforestation",
    "3_5", "Loss to cropland", "Other",
    "4_5", "Loss to cropland", "Other",
    "6_5", "Loss to cropland", "Other",


    "1_4", "Loss to bare land and abandoned", "Deforestation",
    "2_4", "Loss to bare land and abandoned", "Deforestation",
    "3_4", "Loss to bare land and abandoned", "Other",
    "6_4", "Loss to bare land and abandoned", "Other",


    "1_8", "Loss to infrastructure", "Deforestation",
    "2_8", "Loss to infrastructure", "Deforestation",
    "3_8", "Loss to infrastructure", "Other",
    "6_8", "Loss to infrastructure","Other"
  )
  return(traj_lookup)
}



