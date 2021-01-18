#' Update a default color picker input.

#' @name update_default_color_picker
#' @param inputId  \code{[string]}
#' @param value  \code{[string]}  All non-missing elements must comply to regex pattern \code{'''^#'''}.
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{update_default_color_picker}: \code{[invisible(NULL)]}
#' @export
update_default_color_picker <- function(inputId, value, session = getDefaultReactiveDomain()) {
    # Update a default color picker input
    assert_string(inputId)
    assert_string(value, pattern = "^#")
    session$sendInputMessage(inputId, message = value)
    return(invisible(NULL))
    # Returns: \code{[invisible(NULL)]}
}
