#' Get path to LUMENSR example
#'
#' LUMENSR comes bundled with some example files in its `inst/extdata`
#' directory. This function make them easy to access.
#'
#' @param path Name of file. If `NULL`, the example files will be listed.
#' @export
#' @examples
#' LUMENSR_example()
#' LUMENSR_example("ntt_temp.tif")
LUMENSR_example <- function(path = NULL) {
  if (is.null(path)) {
    dir(system.file("extdata", package = "LUMENSR"))
  } else {
    system.file("extdata", path, package = "LUMENSR", mustWork = TRUE)
  }
}
