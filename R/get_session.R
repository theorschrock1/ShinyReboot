#' Get the default shiny session.

#' @name get_session
#' @return \code{get_session}: shiny session
#' @export
get_session <- function() {
    # Get the default shiny session
    shiny::getDefaultReactiveDomain()
    # Returns: shiny session
}
