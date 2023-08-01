#' Calculate land use and land cover change trajectory
#'
#' This function calculates the trajectory map, creates a cross-tabulation of land cover and administrative zones,
#' and plots a bar chart of the trajectory data.
#'
#' @param lc_t1_ A raster layer representing land cover at time 1.
#' @param lc_t2_ A raster layer representing land cover at time 2.
#' @param admin_ A raster layer representing administrative zones.
#' @param lookup_traj_reclass A lookup table for reclassifying trajectories.
#' @param lookup_trajectory_complete A lookup table for completing trajectories.
#' @param trajectory_column_name The name of the trajectory column. Default is "trajectory".
#' @param convert_to_Ha Logical. If TRUE, the pixel counts are converted to hectares. Default is TRUE.
#' @return A list containing the trajectory map, the area table, and the bar plot.
#' @importFrom terra freq
#' @importFrom dplyr group_by summarise mutate arrange select rename
#' @importFrom tidyr drop_na
#' @importFrom stringr str_detect
#' @export
#' @examples
#' \dontrun{
#' ques_pre_trajectory(lc_t1_, lc_t2_, admin_, lookup_traj_reclass, lookup_trajectory_complete)
#' }
ques_pre_trajectory <- function(lc_t1_, lc_t2_, admin_, lookup_traj_reclass, lookup_trajectory_complete, trajectory_column_name = "trajectory", convert_to_Ha = TRUE){

  # Calculate the trajectory map
  luc_trajectory_map <-
    calc_trajectory_map(
      lc_t1_ = lc_t1_,
      lc_t2_ = lc_t2_,
      lookup_traj_reclass = lookup_traj_reclass,
      lookup_trajectory_complete = lookup_trajectory_complete,
      trajectory_column_name = trajectory_column_name
    )

  # Create a cross-tabulation of land cover and administrative zones
  crosstab_traj <- create_crosstab(land_cover = luc_trajectory_map, zone = admin_)[["crosstab_long"]]
  names(crosstab_traj)[1]<- trajectory_column_name

  # Create a frequency table of the trajectory map
  table_traj_area <- luc_trajectory_map |>
    terra::freq() |>
    dplyr::group_by(value) |>
    summarise(count=sum(count)) |> rename("Trajectory" = 1, "Pixel"= 2)

  # Convert pixel counts to hectares if convert_to_Ha is TRUE
  if(convert_to_Ha == TRUE) {
    SpatRes <- calc_res_conv_factor_to_ha(raster_input = lc_t1_)
    crosstab_traj <- mutate(crosstab_traj, Ha = Freq*SpatRes)
    table_traj_area <- mutate(table_traj_area, Ha = Pixel*SpatRes) |> select(-Pixel) |> arrange(-Ha) |> tidyr::drop_na()
  }

  # Create a bar plot of the trajectory data
  barplot_traj <- plot_bar_trajectory(table_traj_area)

  # Store results at landscape level
  landscape_level <- list(
    luc_trajectory_map = luc_trajectory_map,
    #crosstab_traj  = crosstab_traj,
    table_traj_area = table_traj_area,
    barplot_traj = barplot_traj
  )
  # Compute summaries for each planning unit
  pu_names <- crosstab_traj |> pull(names(admin_)) |> unique()
  pu_level <- purrr::map(pu_names, ~ lcc_trajectory_by_pu(crosstab_tbl = crosstab_traj, pu_column = names(admin_), pu_name = .x))
  pu_level <- set_names(pu_level, pu_names)

  return(list(landscape_level = landscape_level, pu_level = pu_level))
}
