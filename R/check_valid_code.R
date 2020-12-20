#' Check if a character string is parsable R code.

#' @name check_valid_code
#' @param x  \code{[string]}  NULL is ok.
#' @param null.ok  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{FALSE}
#' @return \code{check_valid_code}: \code{[TRUE|character(message)]}
#' @examples

#'  x = 'SUM(X)'
#'  check_valid_code('SUM(X)', null.ok = FALSE)
#'  check_valid_code('SUMX)', null.ok = FALSE)
#'  check_valid_code('SUM(X){', null.ok = FALSE)
#'  check_valid_code('SUM(X){}', null.ok = FALSE)
#'  check_valid_code('SUM(X){\'}', null.ok = FALSE)
#'  check_valid_code('SUM(X{\']', null.ok = FALSE)
#' @export
check_valid_code <- function(x, null.ok = FALSE) {
    # Check if a character string is parsable R code
    assert_logical(null.ok, len = 1)
    assert_string(x, null.ok = TRUE)
    if (is.null(x) && !null.ok) 
        return("Must not be NULL")
    if (is.null(x) && null.ok) 
        return(TRUE)
    res = check_string(x)
    if (!isTRUE(res)) 
        return(res)
    out = NULL
    open = str_count(x, "\\(")
    close = str_count(x, "\\)")
    if ((open + close)%%2 != 0) 
        append(out) <- glue("Missing {c('open','closed')[which.min(c(open, close))]} parenthises `{c('(',')')[which.min(c(open, close))]}`")
    open = str_count(x, "\\{")
    close = str_count(x, "\\}")
    if ((open + close)%%2 != 0) {
        btype = c("{", "}")[which.min(c(open, close))]
        append(out) <- glue("Missing {c('open','closed')[which.min(c(open, close))]} curly bracket `{btype}`")
    }
    open = str_count(x, "\\[")
    close = str_count(x, "\\]")
    if ((open + close)%%2 != 0) 
        append(out) <- glue("Missing {c('open','closed')[which.min(c(open, close))]} square bracket `{c('[',']')[which.min(c(open, close))]}`")
    if (str_count(x, "'|\"")%%2 != 0) 
        append(out) <- "Missing or unclosed quotation mark."
    if (nlen0(out)) 
        return(out %sep% ". ")
    return(TRUE)
    # Returns: \code{[TRUE|character(message)]}
}
