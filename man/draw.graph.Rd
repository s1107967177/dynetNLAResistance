% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/draw_graph.R
\name{draw.graph}
\alias{draw.graph}
\title{Draw a graph contains vertexs with sensitive or unsensitive label}
\usage{
draw.graph(g, main = NULL, label = NA)
}
\arguments{
\item{g}{A graph contains vertexs with different labels and some of which are sensitive.}

\item{main}{The title of graph.}

\item{label}{Label of vertexs.}
}
\description{
Draw a graph contains vertexs with sensitive or unsensitive label
}
\examples{
dynet <- make.virtual.dynamic.network()
draw.graph(dynet$t1)
}

