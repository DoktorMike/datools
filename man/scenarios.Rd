% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/models.R
\name{scenarios}
\alias{scenarios}
\title{Create a number of scenarios based on a single observation}
\usage{
scenarios(datapoint, varvals)
}
\arguments{
\item{datapoint}{containing all variables that a scenarios needs in addition
to the ones you want to manipulate}

\item{varvals}{is a named list where each list item is a vector with all the
values you would like to test for the named variable}
}
\value{
a tibble with all the combinations of the values you choose to change
}
\description{
Most common use case is a data.frame full of observations and you want to
simulate different values of a few variables while keeping the others fixed.
This is important in models with interactions as well as non-linear models.
The data.frame return from this function can go directly into a
stats::predict call if the model being predicted on supports that interface.
}
\examples{
scenarios(data.frame(A=0, B=4, C=6), varvals=list(B=c(2,3,6), A=c(1,7,9)))
}
