#' show or hide a draggable model.

#' @name show_draggable_model
#' @param inputId  \code{[string]}  Defaults to \code{NULL}
#' @param top  \code{[number]}  NULL is ok.  Defaults to \code{NULL}
#' @param left  \code{[number]}  NULL is ok.  Defaults to \code{NULL}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{show_draggable_model}: invisible(NULL)
#' @export
show_draggable_model <- function(inputId = NULL, top = NULL, left = NULL,
    session = getDefaultReactiveDomain()) {
    # show or hide a draggable model
    assert_string(inputId)
    assert_number(top, null.ok = TRUE)
    assert_number(left, null.ok = TRUE)
    message <-drop_nulls(list(show = TRUE, top = top, left = left))

    session$sendInputMessage(inputId,message)
    invisible(NULL)
    # Returns: invisible(NULL)
}
