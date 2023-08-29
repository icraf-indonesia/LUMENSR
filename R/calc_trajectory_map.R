#' Calculate Trajectory Map
#'
#' This function calculates the trajectory map by reclassifying two rasters
#' (representing land cover at two different time points), concatenating them,
#' and then adding categorical information based on a provided lookup table.
#'
#' @param lc_t1_ A raster object representing the land cover at time 1.
#' @param lc_t2_ A raster object representing the land cover at time 2.
#' @param lookup_traj_reclass A data frame containing the reclassification rules.
#' @param lookup_trajectory_complete A data frame containing the lookup table for trajectories.
#' @param trajectory_column_name A string representing the column name for the trajectory in the lookup table.
#'
#' @return
#' A raster object representing the trajectory map.
#'
#' @examples
#' \dontrun{
#' # assuming we have two raster objects "lc_t1", "lc_t2",
#' #a reclassification table "lookup_traj_reclass",
#' # and a lookup table "lookup_trajectory_complete"
#' my_trajectory_map <- calc_trajectory_map(lc_t1_, lc_t2_, lookup_traj_reclass,
#' lookup_trajectory_complete,
#' trajectory_column_name = "trajectory")
#' }
#'
#' @export
#' @importFrom terra classify levels concats addCats as.factor
#' @importFrom dplyr select_if select left_join row_number mutate
#' @importFrom tibble tibble

calc_trajectory_map <-
  function(lc_t1_,
           lc_t2_,
           lookup_traj_reclass,
           lookup_trajectory_complete,
           trajectory_column_name = "trajectory") {
    # Reclassify the rasters using the reclassification table
    lc_t1_reclass <-
      reclass_raster_to_categories(raster_map = lc_t1_, reclass_table = lookup_traj_reclass)
    lc_t2_reclass <-
      reclass_raster_to_categories(raster_map = lc_t2_, reclass_table = lookup_traj_reclass)

    # Concatenate the reclassified rasters
    concats_result <- concats(lc_t1_reclass, lc_t2_reclass)

    # Extract the first level from the "concats_result" and convert it to a data frame.
    # Rename the columns as "ID" and "ID_traj".
    lookup_concats <- levels(concats_result)[[1]] %>%
      data.frame() %>%
      dplyr::rename("ID" = 1, "ID_traj" = 2)

    # Create a lookup table for trajectories by subsetting "combinations" for "ID_traj" and "trajectory".
    lookup_traj <-
      lookup_trajectory_complete[c("ID_traj", trajectory_column_name)]

    # Perform a left join operation on "lookup_concats" and "lookup_traj" using "ID_traj" as the key.
    # Remove columns "ID" and "ID_traj" from the result.
    lookup_traj <-
      dplyr::left_join(lookup_concats, lookup_traj, by = "ID_traj") %>%
      dplyr::select(-c("ID", "ID_traj"))

    # Add categorical information to "concats_result" based on the "lookup_traj".
    map_trajectory <- addCats(concats_result, lookup_traj)

    lookup_traj_short <- lookup_traj %>% unique %>% mutate(ID = row_number(), .before = 1)

    names(map_trajectory) <- trajectory_column_name

    reclass_mat <- cats(map_trajectory)[[1]] %>%
      dplyr::select(ID,!!trajectory_column_name) %>%
      left_join(lookup_traj_short, by = trajectory_column_name) %>%
      dplyr::select(-!!trajectory_column_name) %>%
      as.matrix()

    map_trajectory <-
      terra::classify(map_trajectory, reclass_mat) %>%
      terra::as.factor()

    levels(map_trajectory)<- lookup_traj_short

    return(map_trajectory)
  }
