#' Clear the editor selected range.

#' @name ace_clear_selection
#' @param id  \code{[string]}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @param as_is  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{FALSE}
#' @return \code{ace_clear_selection}: invisible(NULL)
#' @export
ace_clear_selection <- function(id, session = getDefaultReactiveDomain(), as_is = FALSE) {
    # Clear the editor selected range
    assert_string(id)
    assert_logical(as_is, len = 1)
    if (!as_is) 
        id <- session$ns(id)
    session$sendCustomMessage("ace-clear-selection", id)
    # Returns: invisible(NULL)
}
