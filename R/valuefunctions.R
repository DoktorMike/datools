#' Replace NA with 0 in a vector
#'
#' This function replaces all NA's in a vector with 0
#'
#' @param x the vector to replace all NA in
#'
#' @return a new vector with all NA's replaced by 0
#' @export
#'
#' @examples
#' naToZero(c(NA, 3:5, NA, NA, 4, 4, 10, NA))
naToZero <- function(x) {
    x[is.na(x)] <- 0
    return(x)
}

#' Replace NA with a user given value in a vector
#'
#' This function replaces all NA's in a vector with a value provided by the user.
#'
#' @param x the vector to replace all NA in
#' @param y the value to replace the NA with
#'
#' @return a new vector with all NA's replaced by y
#' @export
#'
#' @examples
#' naToZero(c(NA, 3:5, NA, NA, 4, 4, 10, NA))
#' naToVal(c(NA, 3:5, NA, NA, 4, 4, 10, NA), 0)
naToVal <- function(x, y = 0) {
    x[is.na(x)] <- y
    return(x)
}

#' Replace non finite values with a user given value in a vector
#'
#' This function replaces all non finite values in a vector with a value provided
#' by the user. NA, NaN, Inf are all examples of non finite values.
#'
#' @param x the vector to replace all non finite values in
#' @param y the value to replace the non finite values with
#'
#' @return a new vector with all non finite values replaced by y
#' @export
#'
#' @examples
#' nonFinToVal(c(NA, 3:5, NA, NA, 4, 4, 10, NA))
#' nonFinToVal(c(NA, 3:5, NA, NA, 4, 4, 10, NA), 3)
nonFinToVal <- function(x, y = 0) {
    x[!is.finite(x)] <- y
    return(x)
}


#' Extrapolate NA's in a univariate vector
#'
#' Extrapolates NA's in the beginning or the end of a univariate vector.
#' Intermediate NA's that occur between two observed values are not touched.
#' Please use interpolation for that case.
#'
#' @param x the univariate vector to extrapolate
#' @param len the number of non NA elements to base the extrapolation on which
#' defaults to 3
#' @return a vector with the NA's in the beginning and the end extrapolated
#' @importFrom utils tail
#' @export
#' @examples
#' extrapolateNA(c(NA, NA, NA, 4, 5, 6, 7, NA, NA))
#' extrapolateNA(c(0, NA, NA, 4, 5, 6, 7, NA, NA))
#' extrapolateNA(c(0, NA, NA, 4, 5, 6, 7, NA, 9))
extrapolateNA <- function(x, len = 3) {
    # browser()
    id <- val <- NA
    if (all(is.na(x))) {
        return(NA)
    }
    tmpdf <- dplyr::tibble(id = seq_along(x), val = x)
    modeldf <- stats::na.omit(tmpdf)
    retdf <- tmpdf
    if (is.na(x[1])) {
        lastheadnaind <- which(!is.na(x))[1] - 1
        tmpdfhead <- tmpdf[1:lastheadnaind, ]
        retdf <- retdf[-c(1:lastheadnaind), ]
        modeldfhead <- utils::head(modeldf, len)
        if (nrow(modeldfhead) < 3) stop("You need at least three observations with non NA")
        myfit <- lm(val ~ id, data = modeldfhead)
        p <- stats::predict(myfit, newdata = tmpdfhead)
        tmpdfhead$val <- p
        retdf <- dplyr::full_join(retdf, tmpdfhead, by = c("id", "val")) %>%
            dplyr::arrange(id)
    }
    if (is.na(utils::tail(x, 1))) {
        firsttailnaind <- utils::tail(which(!is.na(x)), 1) + 1
        tmpdftail <- tmpdf[firsttailnaind:nrow(tmpdf), ]
        retdf <- retdf[-c(firsttailnaind:nrow(tmpdf)), ]
        modeldftail <- utils::tail(modeldf, len)
        myfit <- lm(val ~ id, data = modeldftail)
        p <- stats::predict(myfit, newdata = tmpdftail)
        tmpdftail$val <- p
        retdf <- dplyr::full_join(retdf, tmpdftail, by = c("id", "val")) %>%
            dplyr::arrange(id)
    }
    dplyr::arrange(retdf, id)$val
}

#' Perform linear interpolation of a time series
#'
#' Just what it says with linear interpolation.
#'
#' @param x the vector to interpolate
#' @importFrom stats approx
#'
#' @return an interpolated vector
#' @export
#'
#' @examples
#' interpolateNA(c(1,2,3, NA, NA, NA, 7, 8, 9))
interpolateNA <- function(x) {
    if (all(is.vector(x), is.numeric(x))) {
        inds <- which(is.na(x))
        if (length(inds) > 0) {
              try({
                  x[inds] <- stats::approx(x, xout = inds)$y
              })
          }
    }
    x
}
