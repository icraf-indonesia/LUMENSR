<!-- badges: start -->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R-CMD-check](https://github.com/icraf-indonesia/LUMENSR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/icraf-indonesia/LUMENSR/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/icraf-indonesia/LUMENSR/branch/main/graph/badge.svg)](https://app.codecov.io/gh/icraf-indonesia/LUMENSR?branch=main)
<!-- badges: end -->

# LUMENSR: A Proposal <a href="https://icraf-indonesia.github.io/LUMENSR/"><img src="man/figures/logo.png" align="right" height="138" alt="LUMENSR website" /></a>

**This is an experiment to package the core functions of LUMENS as an R package.** By packaging the functions, LUMENS developers could benefit from improved code organization, version control, and testing capabilities. The proposed exercise will primarily rely on the [devtools](https://github.com/r-lib/devtools).

`LUMENSR` is a tool under experimental development, currently offering the **Pre-QuES** module. This module facilitates the analysis of land use changes by comparing land cover maps from two distinct time periods. The comparison provides valuable insights into how land use in a specific region has transformed over time.

**To get started see:**
- [Pre-QuES Report example](https://icraf-indonesia.github.io/LUMENSR/articles/Pre-QUES.html): an example of LUMENSR report from the **Pre-QuES** module, process land use land cover data into meaningful information on land cover change patterns and composition.
- [Function reference](https://icraf-indonesia.github.io/LUMENSR/reference/index.html): an overview of all LUMENSR functions


# Installation:
As LUMENSR is currently under experimental development, install the latest development version from [GitHub](https://github.com/icraf-indonesia/LUMENSR) using the following commands:

``` r
install.packages("devtools")
devtools::install_github("icraf-indonesia/LUMENSR")
```

After installation, load the package with:
``` r
library(LUMENSR)
```

Once installed, you can use this package in the R console, within [quarto documents](https://quarto.org/) and within [Shiny](http://shiny.rstudio.com/) applications. You may need to download the [quarto CLI](https://quarto.org/docs/get-started/).

# Contributing
We appreciate your feedback and contributions. Please report any problems encountered while using LUMENSR as “issues” on [our GitHub repository](https://github.com/icraf-indonesia/LUMENSR/issues). Your input will help us improve this package!

# A minimal working example
Here's a simple example of how to use LUMENSR:
```r
# Load the LUMENSR package
library(LUMENSR)

# Load the example raster files and convert them into a terra::rast object
# Add a legend to the raster using a lookup table
NTT_LC90 <- LUMENSR_example("NTT_LC90.tif")
NTT_LC90_rast <- terra::rast(NTT_LC90)
NTT_LC90_legend <- add_legend_to_categorical_raster(raster_file = NTT_LC90_rast, lookup_table = lc_lookup_klhk_sequence)

NTT_LC20 <- LUMENSR_example("NTT_LC20.tif")
NTT_LC20_rast <- terra::rast(NTT_LC20)
NTT_LC20_legend <- add_legend_to_categorical_raster(raster_file = NTT_LC20_rast, lookup_table = lc_lookup_klhk_sequence)

# Create a frequency table from the list of raster files
raster_list <- list(NTT_LC90_legend, NTT_LC20_legend)
crosstab_result <- create_crosstab(raster_list)
crosstab_result_abbreviated <- abbreviate_by_column(crosstab_result, c("NTT_LC90", "NTT_LC20"), remove_vowels = FALSE)

# Create a Sankey diagram from the frequency table
create_sankey(crosstab_result_abbreviated, area_cutoff = 10000, change_only = FALSE)
```
![image](https://github.com/icraf-indonesia/LUMENSR/assets/14798903/b01d5d42-fa5d-44a5-ae29-eb80f5401bb3)


# Interested in preparing and producing a Pre-QUES report?
Navigate to the following link for a well-commented example Quarto script. Download the [`qmd` files](https://github.com/icraf-indonesia/LUMENSR/tree/main/vignettes/articles) and render them using:
```r
quarto::quarto_render("Pre-QUES.qmd")
```
