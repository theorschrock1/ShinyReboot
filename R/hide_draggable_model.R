#' show or hide a draggable model.

#' @name hide_draggable_model
#' @param inputId  \code{[string]}  Defaults to \code{NULL}
#' @param top  \code{[number]}  NULL is ok.  Defaults to \code{NULL}
#' @param left  \code{[number]}  NULL is ok.  Defaults to \code{NULL}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{hide_draggable_model}: invisible(NULL)
#' @rdname show_draggable_model
#' @export
hide_draggable_model <- function(inputId = NULL, top = NULL, left = NULL, 
    session = getDefaultReactiveDomain()) {
    # show or hide a draggable model
    assert_string(inputId)
    assert_number(top, null.ok = TRUE)
    assert_number(left, null.ok = TRUE)
    session$sendInputMessage(inputId, value = drop_nulls(list(show = FALSE, 
        top = top, left = left)))
    invisible(NULL)
    # Returns: invisible(NULL)
}
