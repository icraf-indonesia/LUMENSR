#' @title Pre-QUES Land cover change analysis
#' @description This function preprocesses land cover data for visualization, calculation, and summarization.
#' It checks the consistency of input data, creates visualizations of input data, calculates land cover frequency,
#' creates a crosstabulation of land cover changes, and summarizes results at both the landscape and planning unit level.
#' The function also converts pixels to hectares if `convert_to_Ha` is set to TRUE.
#' @param lc_t1 A spatRaster object representing land cover data for period T1.
#' @param lc_t2 A spatRaster object representing land cover data for period T2.
#' @param admin_ A spatRaster object representing planning unit data. Can also be a sf multipolygon object,
#' in which case it will be rasterized.
#' @param cutoff_landscape minimum number of pixel/ area to be displayed in sankey plot at landscape level
#' @param cutoff_pu minimum number of pixel/ area to be displayed in sankey plot at planing unit level
#' @param convert_to_Ha Logical flag indicating whether to convert pixel count to hectares based on the resolution of the `lc_t1` raster.
#' @return A list of results containing input data visualizations, landscape level results, and planning unit level results.
#' @importFrom terra rast cats compareGeom
#' @importFrom dplyr select group_by_at summarise pull
#' @importFrom purrr map
#' @importFrom rlang set_names
#' @importFrom methods is
#' @export
#' @examples
#' \dontrun{
#' ## Load and annotate land cover data for period T1
#' lc_t1_ <- LUMENSR_example("NTT_LC90.tif") %>%
#'   terra::rast() %>%
#'   add_legend_to_categorical_raster(
#'     raster_file = .,
#'     lookup_table = lc_lookup_klhk_sequence
#'   ) |> assign_time_period(year_ = as.character(1990))
#' ## Load and annotate land cover data for period T2
#' lc_t2_ <- LUMENSR_example("NTT_LC20.tif") %>%
#'   terra::rast() %>%
#'   add_legend_to_categorical_raster(
#'     raster_file = .,
#'     lookup_table = lc_lookup_klhk_sequence
#'   ) |> assign_time_period(year_ = as.character(2020))
#' # Load planning unit data
#' admin_z <- LUMENSR_example("ntt_admin_spatraster.tif") %>%
#'   terra::rast()
#' ques_pre(lc_t1_, lc_t2_, admin_z)
#' }

ques_pre <- function(lc_t1, lc_t2, admin_, cutoff_landscape = 5000, cutoff_pu = 500, convert_to_Ha = TRUE) {

  ## Plot planning unit
  if (!is(admin_, "SpatRaster")) {
    stopifnot(is(admin_, "sf")) # Ensure admin_ is either SpatRaster or sf (multipolygon)
    plot_admin <- plot_planning_unit(admin_) #%>% ggplot_to_image(image_width = 20, image_height = 14)
    admin_ <- rasterise_multipolygon(admin_) # convert admin_ to a spatraster
  } else {

    plot_admin <- plot_categorical_raster(admin_) #%>% ggplot_to_image(image_width = 20, image_height = 14)

  }


  # Guardrails to check the input types
  stopifnot(is(lc_t1, "SpatRaster"), is(lc_t2, "SpatRaster"))

  # Guardrails to check if the input rasters have attribute tables
  stopifnot(!is.null(cats(lc_t1)[[1]]), !is.null(cats(lc_t2)[[1]]))

  # Guardrail to ensure identical extent and projection system
  compareGeom(lc_t1, lc_t2, admin_, stopOnError = TRUE)

  # Plot land cover for both periods and the planning unit
  ## Plot land cover T1
  plot_lc_t1 <- plot_categorical_raster(lc_t1) #%>% ggplot_to_image(image_width = 20, image_height = 14)
  ## Plot land cover T2
  plot_lc_t2 <- plot_categorical_raster(lc_t2) #%>% ggplot_to_image(image_width = 20, image_height = 14)

  # Calculate and tabulate land cover composition
  lc_freq_table <- calc_lc_freq(raster_list = list(lc_t1, lc_t2)) %>%
    abbreviate_by_column( "Jenis tutupan lahan", remove_vowels = FALSE)
  lc_composition_tbl <- lc_freq_table #%>%
    #rmarkdown::paged_table(options = list(cols.min.print = 3))

  # Plot land cover composition
  lc_composition_barplot <- lc_freq_table %>%
    plot_lc_freq(column_lc_type = "Jenis tutupan lahan",
                 column_T1 = names(lc_freq_table)[2],
                 column_T2 = names(lc_freq_table)[3])

  # Store visualization results
  input_dataviz <- list(
    plot_lc_t1 = plot_lc_t1,
    plot_lc_t2 = plot_lc_t2,
    plot_admin = plot_admin,
    tbl_lookup_lc_t1 = cats(lc_t1)[[1]],
    tbl_lookup_lc_t2 = cats(lc_t2)[[1]],
    tbl_lookup_admin = cats(admin_)[[1]],
    lc_composition_tbl = lc_composition_tbl,
    lc_composition_barplot = lc_composition_barplot
  )
  # Create crosstabulation
  crosstab_matrix_landscape <- create_crosstab(land_cover = c(lc_t1, lc_t2))[["crosstab_square"]] |>
    as.data.frame.matrix()

  crosstab_result <- create_crosstab(land_cover = c(lc_t1, lc_t2), zone = admin_)[["crosstab_long"]]

  # Get spatResolution
  if( convert_to_Ha == TRUE) {
    SpatRes <- calc_res_conv_factor_to_ha(raster_input = lc_t1)

    crosstab_result <- mutate(crosstab_result, Ha = Freq*SpatRes)
    crosstab_matrix_landscape <- crosstab_result
  }

  # Summarize crosstabulation at landscape level
  # Subsetting the crosstab_result data frame
  selected_cols <- select(crosstab_result, -names(admin_))

  # Getting the names of the columns to be grouped
  group_cols <- setdiff(names(selected_cols), c("Freq", "Ha"))

  # Grouping the data frame by the columns selected above
  grouped_df <- group_by_at(selected_cols, group_cols)

  # Summarizing the grouped data
  if ("Ha" %in% names(grouped_df)) {
    crosstab_landscape <- summarise(grouped_df, Freq = sum(Freq), Ha = sum(Ha), .groups = "drop")
  } else {
    crosstab_landscape <- summarise(grouped_df, Freq = sum(Freq), .groups = "drop")
  }
  # Create Sankey diagrams at landscape level
  ## Sankey diagram showing all changes
  sankey_landscape <- crosstab_landscape %>%
    create_sankey(area_cutoff = cutoff_landscape, change_only = FALSE)

  ## Sankey diagram showing only changes
  sankey_landscape_chg_only<- crosstab_landscape %>%
    create_sankey(area_cutoff = cutoff_landscape, change_only = TRUE)

  # Compute 10 dominant land use changes
  luc_top_10 <- crosstab_landscape %>% calc_top_lcc(n_rows = 10)

  # Tabulate and plot 10 dominant land use changes
  luc_top_10_barplot <- luc_top_10 %>%
    plot_lcc_freq_bar(col_T1 = as.character(time(lc_t1)), col_T2 = as.character(time(lc_t2)),
                      Freq = if ("Ha" %in% names(luc_top_10)) "Ha" else "Freq")

  # Store results at landscape level
  landscape_level <- list(
    sankey_landscape= sankey_landscape,
    sankey_landscape_chg_only = sankey_landscape_chg_only,
    luc_top_10_tbl = luc_top_10,
    luc_top_10_barplot = luc_top_10_barplot,
    crosstab_landscape = crosstab_matrix_landscape,
    crosstab_long = crosstab_result
  )

  # Compute summaries for each planning unit
  pu_names <- crosstab_result %>% pull(names(admin_)) %>% unique()
  pu_level <- purrr::map(pu_names, ~ lcc_summary_by_pu(crosstab_tbl = crosstab_result, pu_column = names(admin_), pu_name = .x, sankey_area_cutoff = cutoff_pu, n_top_lcc = 10))
  pu_level <- set_names(pu_level, pu_names)

  # Return all results
  return(list(input_dataviz = input_dataviz, landscape_level = landscape_level, pu_level = pu_level))
}
