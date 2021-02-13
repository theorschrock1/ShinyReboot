#' Update a range slider input.

#' @name update_range_slider_input
#' @param ...
#' @param inputId  \code{[string]}
#' @param lower_val  \code{[number]}  NULL is ok.  Defaults to \code{NULL}
#' @param upper_val  \code{[number]}  NULL is ok.  Defaults to \code{NULL}
#' @param range  \code{[numeric]}  Must have an exact length of \code{2}.  NULL is ok.  Defaults to \code{NULL}
#' @param label  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param signif  \code{[int]}  NULL is ok.  Defaults to \code{NULL}
#' @param prefix  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param suffix  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{update_range_slider_input}: \code{[invisible(NULL)]}
#' @examples

#'  update_range_slider_input(inputId = 'myid', lower_val = 4,
#'  upper_val = 5, range = c(0, 10), label = 'new_label',
#'  signif = 4, prefix = '$')
#' @export
update_range_slider_input <- function(..., inputId, lower_val = NULL, upper_val = NULL, 
    range = NULL, label = NULL, signif = NULL, prefix = NULL, suffix = NULL, session = getDefaultReactiveDomain()) {
    # Update a range slider input
    dots = assert_named(list(...))
    dots$lower = assert_number(lower_val, null.ok = TRUE)
    dots$upper = assert_number(upper_val, null.ok = TRUE)
    dots$range = assert_numeric(range, len = 2, null.ok = TRUE)
    dots$label = assert_string(label, null.ok = TRUE)
    dots$signif = assert_int(signif, null.ok = TRUE)
    dots$prefix = assert_string(prefix, null.ok = TRUE)
    dots$suffix = assert_string(suffix, null.ok = TRUE)
    assert_string(inputId)
    minr = NULL
    maxr = NULL
    if (nnull(dots$range)) {
        minr = min(dots$range)
        maxr = max(dots$range)
    }
    value = list(to = dots$lower, from = dots$upper, min = minr, max = maxr, step = dots$step)
    dots$max = maxr
    dots$min = minr
    dots$range = NULL
    message = drop_nulls(list(value = drop_nulls(value), label = dots$label, data = drop_nulls(dots[names(dots) %nin% 
        c("label")])))
    if (is.null(session)) {
        print("Warning: NULL session: returning message")
        return(message)
    }
    updateInput(inputId, value = message, session = session)
    # Returns: \code{[invisible(NULL)]}
}
