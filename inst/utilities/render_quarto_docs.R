library(quarto)

# Set the input file path
input_file <- "~/GitHub/LUMENSR/inst/docs/Pre-QuES.qmd"

# Set the working directory to the desired output directory
setwd("~/GitHub/LUMENSR/docs/articles")

# Render the Quarto document
quarto_render(
  input = input_file,
  output_format = "html"
)

setwd("~/GitHub/LUMENSR")
