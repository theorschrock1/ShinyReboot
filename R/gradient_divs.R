#' Create a series of div colored by a stepped gradient.

#' @name gradient_divs
#' @param ...
#' @param n
#' @param domain
#' @param range
#' @return \code{gradient_divs}: \code{[list]}
#' @examples

#'  gradient_divs(class = 'flex-fill', n = 5, domain = continuous_pal('Blues',
#'  n = 3), range = c(0, 4, 5))
#' @export
gradient_divs <- function(..., n, domain, range) {
    # Create a series of div colored by a stepped gradient
    colors <- gradient_scale(domain, range)(bins = n)
    lapply(colors, function(x, ...) {
        div(style = glue("background-color:{x};"), `data-color` = x) %>% tagAppendAttributes(...)
    }, ...)
    # Returns: \code{[list]}
}
