#' Send a shiny message to the browser.

#' @name sendCustomMessage
#' @param id  \code{[string]}
#' @param message
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{sendCustomMessage}: \code{[invisible(NULL)]}
#' @export
sendCustomMessage <- function(id, message, session = getDefaultReactiveDomain()) {
    # Send a shiny message to the browser
    assert_string(id)
    session$sendCustomMessage(type = id, message)
    return(invisible(NULL))
    # Returns: \code{[invisible(NULL)]}
}
