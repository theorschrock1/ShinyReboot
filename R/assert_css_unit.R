#' Checks that the argument is valid for use as a CSS unit of length.

#' @name assert_css_unit
#' @param x  \code{[number|string]}
#' @return \code{assert_css_unit}: \code{[invisible(x)]} if valid, otherwise throws an error.
#' @export
assert_css_unit <- function(x) {
    # Checks that the argument is valid for use as a CSS unit of length

    if (is.null(x) || is.na(x))
        return(x)
    if (length(x) > 1 || (!is.character(x) && !is.numeric(x)))
        g_stop("CSS units must be a single-element numeric or character vector")
    if (is.character(x) && nchar(x) > 0 && gsub("\\d*", "", x) == "")
        x <- as.numeric(x)
    pattern <- "^(auto|inherit|fit-content|calc\\(.*\\)|((\\.\\d+)|(\\d+(\\.\\d+)?))(%|in|cm|mm|ch|em|ex|rem|pt|pc|px|vh|vw|vmin|vmax|fr))$"
    if (is.character(x) && !grepl(pattern, x)) {
        stop("\"", x, "\" is not a valid CSS unit (e.g., \"100%\", \"400px\", \"auto\")")
    } else if (is.numeric(x)) {
        x <- paste(x, "px", sep = "")
    }
    x
    # Returns: [invisible(x)] if valid, otherwise throws an error.
}
