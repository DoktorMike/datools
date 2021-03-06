% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/linearmodelsutils.R
\name{vif}
\alias{vif}
\title{Calculate the VIF for data}
\usage{
vif(mod)
}
\arguments{
\item{mod}{the data to process}
}
\value{
A matrix containing the VIF and standardised VIF factors
}
\description{
Calculate the Variance Inflation Factor for a dataset.
}
\examples{
library(MASS)
data("birthwt")
vif(lm(bwt ~ low + smoke + age + race, data = birthwt))
vif(birthwt)
}
