% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_polygon_map.R
\name{plot_planning_unit}
\alias{plot_planning_unit}
\title{Create a plot of a spatial planning unit with labels.}
\usage{
plot_planning_unit(planning_unit, map_label = NULL)
}
\arguments{
\item{planning_unit}{A sf object representing the planning units.}

\item{map_label}{A string representing the column name to use for labels. If empty, the second column of planning_unit is used.}
}
\value{
A ggplot object.
}
\description{
This function creates a plot using ggplot2 where each planning unit is
represented as a polygon filled with light green color. The unit names
are added as text labels that repel each other to minimize overlap.
}
