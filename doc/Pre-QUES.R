## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(LUMENSR)
library(magrittr)
library(dplyr)
library(purrr)
library(networkD3)
library(terra)
library(sf)
library(ggplot2)
library(ggrepel)
library(stringr)
library(viridis)
library(scales)

## ----echo=FALSE, fig.height=8, fig.width=12-----------------------------------
NTT_LC90 <- LUMENSR_example("NTT_LC90.tif") %>%
									 terra::rast() %>%
									 add_legend_to_categorical_raster(
									 raster_file = .,
									 lookup_table = lc_lookup_klhk_sequence)

plot_categorical_raster(NTT_LC90)

## ----echo=FALSE, fig.height=8, fig.width=12-----------------------------------

NTT_LC20 <- LUMENSR_example("NTT_LC20.tif") %>%
									 terra::rast() %>%
									 add_legend_to_categorical_raster(
									 raster_file = .,
									 lookup_table = lc_lookup_klhk_sequence)

plot_categorical_raster(NTT_LC20)

## ----echo=FALSE, fig.height=8, fig.width=12-----------------------------------
 plot_planning_unit(ntt_admin, "Kabupaten")

## ----echo=FALSE---------------------------------------------------------------
tabel_singkatan <- lc_lookup_klhk %>%
  abbreviate_lookup() %>% 
  dplyr::select(-color_pallette)

tabel_singkatan %>% rmarkdown::paged_table()

## ----echo=FALSE---------------------------------------------------------------
lc_freq_table <- calc_lc_freq(raster_list = list(NTT_LC90, NTT_LC20))
lc_freq_table %>% 
  abbreviate_by_column( "Jenis tutupan lahan", remove_vowels = FALSE) %>%
  rmarkdown::paged_table(options = list(cols.min.print = 3))

## ----echo=FALSE, fig.height=8, fig.width=12-----------------------------------
lc_freq_table %>% 
  abbreviate_by_column( "Jenis tutupan lahan", remove_vowels = FALSE) %>% 
  plot_lc_freq(column_lc_type = "Jenis tutupan lahan", 
               column_T1 = "NTT_LC90_count", 
               column_T2 = "NTT_LC20_count")

## ----echo=FALSE---------------------------------------------------------------
raster_files <- c("NTT_LC90.tif", "NTT_LC20.tif") %>%
    map(LUMENSR_example) %>%
    map(rast)

# Loop through raster files
raster_list <- 
  map(raster_files, ~ apply_lookup_table(raster_file = .x, lookup_lc = lc_lookup_klhk_sequence))

# Turn raster files into a frequency table
crosstab_result <- create_crosstab(raster_list)

## ----echo=FALSE, fig.height=8, fig.width=12-----------------------------------
# Input
crosstab_result_abbreviated <- crosstab_result %>% 
  abbreviate_by_column( c("NTT_LC90", "NTT_LC20"), remove_vowels = FALSE)

create_sankey(freq_table = crosstab_result_abbreviated, area_cutoff = 10000, change_only = FALSE)

## ----echo=FALSE, fig.height=8, fig.width=12-----------------------------------
create_sankey(freq_table = crosstab_result_abbreviated, area_cutoff = 10000, change_only = TRUE)

## ----echo=FALSE---------------------------------------------------------------
luc_top_10 <- crosstab_result %>% calc_top_lcc(n_rows = 10) %>%
  abbreviate_by_column( c("NTT_LC90", "NTT_LC20"), remove_vowels = FALSE)

luc_top_10 %>% rmarkdown::paged_table()

## ----echo=FALSE, fig.height=8, fig.width=12-----------------------------------
luc_top_10 %>% plot_lcc_freq_bar(col_T1 = "NTT_LC90" , col_T2 = "NTT_LC20",Freq = "Freq")


