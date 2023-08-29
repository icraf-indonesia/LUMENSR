#' Create a Color Lookup Table for Forest Definitions
#'
#' This function generates a tibble that maps forest definitions to their corresponding color codes.
#' The function will return a tibble containing two columns: 'def' for forest definitions and 'hex_color' for color codes.
#'
#' @return A tibble containing forest definitions and their corresponding color codes
#' @export
#' @importFrom tibble tibble
color_forest_trajectories <- function() {
  # Define the tibble with forest definitions and their corresponding colors
  color_lookup_def <- tibble(
    def = c(
      "Stable forest",
      "Forest degradation",
      "Deforestation",
      "Reforestation",
      "Other"
    ),
    color_palette = c("#006400", "#FFD700", "#FF4500", "#90EE90" , "#808080")
  )

  # Return the color lookup table
  return(color_lookup_def)
}


#' Create a Color Lookup Table for Trajectory Categories
#'
#' This function generates a tibble that maps trajectory categories to their corresponding color codes.
#' The function returns a tibble containing two columns: 'trajectory' for the categories and 'hex_color' for the color codes.
#'
#' @return A tibble containing trajectory categories and their corresponding color codes
#' @export
#' @importFrom tibble tibble
color_landuse_trajectories <- function() {
  # Create the tibble with trajectory categories and their corresponding colors
  color_lookup_trajectory <- tibble(
    trajectory = c(
      "Stable natural forest",
      "Recovery to forest",
      "Loss to logged-over forest",
      "Other",
      "Recovery to tree cropping",
      "Loss to bare land and abandoned",
      "Loss to cropland",
      "Recovery to agroforest",
      "Loss to infrastructure"
    ),
    color_palette = c(
      "#228B22",  # Green for stable natural forest
      "#ADFF2F",  # Light Green for forest recovery
      "#FF8424",  # Goldenrod for logged-over forest loss
      "#808080",  # Grey for other
      "#8B4513",  # Saddle Brown for tree cropping
      "#FE6AB2",  # Crimson for bare land and abandoned
      "#FFFE00",  # Orange Red for cropland loss
      "#9E00B3",  # Pale Violet Red for agroforest recovery
      "#FF0000"   # Dark Red for infrastructure loss
    )
  )

  # Return the color lookup table
  return(color_lookup_trajectory)
}

