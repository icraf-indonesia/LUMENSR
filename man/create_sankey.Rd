% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_sankey.R
\name{create_sankey}
\alias{create_sankey}
\title{Create a Sankey Diagram}
\usage{
create_sankey(freq_table, area_cutoff = 10000, change_only = FALSE)
}
\arguments{
\item{freq_table}{A frequency table containing land cover T1, T2, T3, etc..
and a Frequency column (numeric). If a column named "Ha" exists, it will be used instead of "Freq".}

\item{area_cutoff}{Minimum number of pixels of land use land cover frequency to include.}

\item{change_only}{Logical flag, if TRUE exclude persistent land cover.}
}
\value{
A Sankey plot.
}
\description{
This function takes a frequency table (crosstab) as input and creates a Sankey diagram.
If a column named "Ha" exists in the frequency table, it will be used for filtering and sorting,
otherwise it will fall back to using the "Freq" column.
}
\examples{
\dontrun{
  synthetic_data <- data.frame(
    "1990" = rep(c("Forest", "Urban", "Agriculture", "Water"), each = 4),
    "2020" = rep(c("Forest", "Urban", "Agriculture", "Water"), 4),
    Freq = sample(1:100, 16)
  ) \%>\%
    dplyr::arrange("1990")

  create_sankey(freq_table = synthetic_data, area_cutoff = 0, change_only = FALSE)
}
}
\author{
Dony Indiarto
}
