#' Save ggplot2 plot as an Image Object
#'
#' This function saves a ggplot2 plot as a magick image object, using the desired width and height in inches and dpi resolution.
#'
#' @param plot_object ggplot2 plot that needs to be saved as image.
#' @param image_width Width of the image in inches. Default is 10.
#' @param image_height Height of the image in inches. Default is 10.
#' @param image_resolution Resolution of the image in dpi. Default is 300.
#'
#' @importFrom magick image_graph
#' @importFrom utils capture.output
#' @importFrom grDevices dev.off
#' @importFrom graphics par
#' @export
#' @return A magick image object of the ggplot2 plot.
#'
#' @examples
#' \dontrun{
#' library(ggplot2)
#' p <- ggplot(mpg, aes(displ, hwy, colour = class)) + geom_point()
#' img <- ggsave_to_image(p)
#' }
#' @export
ggplot_to_image <- function(plot_object, image_width = 10, image_height = 10, image_resolution = 300){
  # Calculate pixel dimensions based on desired image width, height and resolution
  pixel_width  = (image_width  * image_resolution) / 2.54
  pixel_height = (image_height * image_resolution) / 2.54

  # Create a new magick image object with specified pixel dimensions and resolution
  image_object <- image_graph(pixel_width, pixel_height, res = image_resolution)

  # Ensure graphic device is turned off on exit, even if errors occur
  on.exit(capture.output({dev.off()}))

  # Plot the input ggplot2 object
  par(oma=c(0,0,0,0))
  par(mar=c(0,0,0,0) + 0.1)
  plot(plot_object)

  # Return the magick image object
  return(image_object)
}
