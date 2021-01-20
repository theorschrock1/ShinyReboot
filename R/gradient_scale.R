#' Create a number gradient interpolator.

#' @name gradient_scale
#' @param domain  \code{[character]}  All non-missing elements must comply to regex pattern \code{'''^#'''}.
#' @param range  \code{[numeric]}  Must have an exact length of \code{length(domain)}.
#' @return \code{gradient_scale}: \code{[function]}
#' @export
gradient_scale <- function(domain, range) {
    # Create a number gradient interpolator
    assert_character(domain, pattern = "^#")
    assert_numeric(range, len = length(domain))
    fn = gradient_n_pal(domain, values = rescale(range, to = c(0, 1)), space = "Lab")
    function(x, bins = NULL) {
        if (nnull(bins)) 
            return(fn(seq(0, 1, length.out = bins)))
        rx = rescale(x, to = c(0, 1))
        fn(rx)
    }
    # Returns: \code{[function]}
}
