#' @title Pre-QUES Land cover change analysis
#' @description This function preprocesses land cover data for visualization, calculation, and summarization.
#' @param lc_t1 A spatRaster object representing land cover data for period T1.
#' @param lc_t2 A spatRaster object representing land cover data for period T2.
#' @param admin_ A spatRaster object representing planning unit data.
#' @return A list of results containing input data visualizations, landscape level results, and planning unit level results.
#' @importFrom terra rast cats
#' @importFrom dplyr select group_by_at summarise pull
#' @importFrom purrr map
#' @importFrom rlang set_names
#' @importFrom rmarkdown paged_table
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
#'   )
#' ## Load and annotate land cover data for period T2
#' lc_t2_ <- LUMENSR_example("NTT_LC20.tif") %>%
#'   terra::rast() %>%
#'   add_legend_to_categorical_raster(
#'     raster_file = .,
#'     lookup_table = lc_lookup_klhk_sequence
#'   )
#' # Load planning unit data
#' admin_z <- LUMENSR_example("ntt_admin_spatraster.tif") %>%
#'   terra::rast()
#' ques_pre(lc_t1_, lc_t2_, admin_z)
#' }
ques_pre <- function(lc_t1, lc_t2, admin_) {

  # Guardrails to check the input types
  stopifnot(is(lc_t1, "SpatRaster"), is(lc_t2, "SpatRaster"), is(admin_, "SpatRaster"))

  # Guardrails to check if the input rasters have attribute tables
  stopifnot(!is.null(cats(lc_t1)[[1]]), !is.null(cats(lc_t2)[[1]]), !is.null(cats(admin_)[[1]]))

  # Plot land cover for both periods and the planning unit
  ## Plot land cover T1
  plot_lc_t1 <- plot_categorical_raster(lc_t1)
  ## Plot land cover T2
  plot_lc_t2 <- plot_categorical_raster(lc_t2)
  ## Plot planning unit
  plot_admin <- plot_categorical_raster(admin_)

  # Calculate and tabulate land cover composition
  lc_freq_table <- calc_lc_freq(raster_list = list(lc_t1, lc_t2)) %>%
    abbreviate_by_column( "Jenis tutupan lahan", remove_vowels = FALSE)
  lc_composition_tbl <- lc_freq_table %>%
    rmarkdown::paged_table(options = list(cols.min.print = 3))

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
  raster_list <- list(lc_t1, lc_t2, admin_)
  crosstab_result <- create_crosstab(raster_list) %>%
    abbreviate_by_column( c(names(lc_t1), names(lc_t2)), remove_vowels = FALSE)

  # Summarize crosstabulation at landscape level
  # Subsetting the crosstab_result data frame
  selected_cols <- select(crosstab_result, -names(admin_))

  # Getting the names of the columns to be grouped
  group_cols <- setdiff(names(selected_cols), "Freq")

  # Grouping the data frame by the columns selected above
  grouped_df <- group_by_at(selected_cols, group_cols)

  # Summarizing the grouped data
  crosstab_landscape <- summarise(grouped_df, Freq = sum(Freq), .groups = "drop")


  # Create Sankey diagrams at landscape level
  ## Sankey diagram showing all changes
  sankey_landscape <- crosstab_landscape %>%
    create_sankey(area_cutoff = 1000, change_only = FALSE)
  ## Sankey diagram showing only changes
  sankey_landscape_chg_only<- crosstab_landscape %>%
    create_sankey(area_cutoff = 1000, change_only = TRUE)

  # Compute 10 dominant land use changes
  luc_top_10 <- crosstab_landscape %>% calc_top_lcc(n_rows = 10)

  # Tabulate and plot 10 dominant land use changes
  luc_top_10_tbl <- luc_top_10 %>% rmarkdown::paged_table()
  luc_top_10_barplot <- luc_top_10 %>% plot_lcc_freq_bar(col_T1 = names(lc_t1) , col_T2 = names(lc_t2), Freq = "Freq")

  # Store results at landscape level
  landscape_level <- list(
    sankey_landscape= sankey_landscape,
    sankey_landscape_chg_only = sankey_landscape_chg_only,
    luc_top_10_tbl = luc_top_10_tbl,
    luc_top_10_barplot = luc_top_10_barplot
  )

  # Compute summaries for each planning unit
  pu_names <- crosstab_result %>% pull(names(admin_)) %>% unique()
  pu_level <- purrr::map(pu_names, ~ lcc_summary_by_pu(crosstab_tbl = crosstab_result, pu_column = names(admin_), pu_name = .x, sankey_area_cutoff = 100, n_top_lcc = 10))
  pu_level <- set_names(pu_level, pu_names)

  # Return all results
  return(list(input_dataviz = input_dataviz, landscape_level = landscape_level, pu_level = pu_level))
}
