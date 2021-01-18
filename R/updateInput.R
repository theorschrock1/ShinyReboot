#' Update a shiny input.

#' @name updateInput
#' @param inputId  \code{[string]}
#' @param value
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{updateInput}: \code{[invisible(NULL)]}
#' @export
updateInput <- function(inputId, value, session = getDefaultReactiveDomain()) {
    # Update a shiny input
    assert_string(inputId)
    session$sendInputMessage(inputId, value)
    # Returns: \code{[invisible(NULL)]}
}
