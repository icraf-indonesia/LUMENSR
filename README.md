<!-- badges: start -->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![R-CMD-check](https://github.com/icraf-indonesia/LUMENSR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/icraf-indonesia/LUMENSR/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/icraf-indonesia/LUMENSR/branch/main/graph/badge.svg)](https://app.codecov.io/gh/icraf-indonesia/LUMENSR?branch=main)
<!-- badges: end -->

# LUMENSR: A Proposal <a href="https://icraf-indonesia.github.io/LUMENSR/"><img src="man/figures/logo.png" align="right" height="138" alt="LUMENSR website" /></a>

**This is an experiment to package the core functions of LUMENS as an R package.** By packaging the functions, LUMENS developers could benefit from improved code organization, version control, and testing capabilities. The proposed exercise will primarily rely on the [devtools](https://github.com/r-lib/devtools).

## Installation

You can install the current version of `LUMENSR` from 
[GitHub](https://github.com/): 
``` r
install.packages("devtools")
devtools::install_github("icraf-indonesia/LUMENSR")
```

Packaging LUMENS functions as an R package would allow developers to selectively load only the functions they need, reducing the memory footprint and improving the speed of their analyses. The package would also come with built-in testing frameworks via [testthat](https://github.com/r-lib/testthat), allowing developers to write tests for their functions and catch bugs early on in the development process.

In addition, packaging LUMENS functions as an R package would make it easier for developers to write detailed documentation for their functions, reducing the time required for onboarding and support. It would also allow for greater modularity and organization, as developers could selectively update and improve specific functions without having to modify the entire codebase.
