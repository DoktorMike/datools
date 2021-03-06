#' Mean absolute error
#'
#' @param o the observed value (trueth)
#' @param p the predicted value (estimation)
#' @return a scalar value
#' @export
mae <- function(o, p) mean(abs(p-o))

#' Mean absolute percentage error
#'
#' @param o the observed value (trueth)
#' @param p the predicted value (estimation)
#' @return a scalar value
#' @export
mape <- function(o, p) mean(abs((p-o)/o))

#' Mean absolute scaled error
#'
#' @param o the observed value (trueth)
#' @param p the predicted value (estimation)
#' @return a scalar value
#' @export
mase <- function(o, p) {
    n <- length(o) - 1
    mean(abs(tail(p, n)-tail(o, n)))/mean(abs(diff(o)))
}

#' Weighted mean absolute percentage error
#'
#' @param o the observed value (trueth)
#' @param p the predicted value (estimation)
#' @return a scalar value
#' @export
wmape <- function(o, p) sum(abs(p-o))/sum(abs(o))

#' Mean squared error
#'
#' @param o the observed value (trueth)
#' @param p the predicted value (estimation)
#' @return a scalar value
#' @export
mse <- function(o, p) mean((p-o)**2)

#' Root mean squared error
#'
#' @param o the observed value (trueth)
#' @param p the predicted value (estimation)
#' @return a scalar value
#' @export
rmse <- function(o, p) sqrt(mean((p-o)**2))


