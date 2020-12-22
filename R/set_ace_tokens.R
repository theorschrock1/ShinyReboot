#' Set highlighting tokens for an ace editor.

#' @name set_ace_tokens
#' @param inputId  \code{[string]}
#' @param tokens  \code{[list]}
#' @param as_is  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{FALSE}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{set_ace_tokens}: \code{[invisible(NULL)]}
#' @export
set_ace_tokens <- function(inputId, tokens, as_is = FALSE, session = getDefaultReactiveDomain()) {
    # Set highlighting tokens for an ace editor
    assert_string(inputId)
    assert_list(tokens)
    assert_logical(as_is, len = 1)
    lapply(tokens, function(x) {
        assert_named_list(x, structure = list(token = string(), regex = string()))
    })
    if (!as_is) 
        inputId = session$ns(inputId)
    params <- toJSON(list(id = inputId, tokens = tokens), auto_unbox = TRUE)
    session$sendCustomMessage("set-ace-editor", params)
    # Returns: \code{[invisible(NULL)]}
}
