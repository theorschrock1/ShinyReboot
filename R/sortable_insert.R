#' insert html into a sortable div.

#' @name sortable_insert
#' @param ...
#' @param inputId  \code{[string]}
#' @param where  \code{[choice]}  Possible values: \code{c('start', 'end', 'before', 'after')}.  Defaults to \code{'start'}
#' @param data_id  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{sortable_insert}: \code{[invisible(NULL)]}
#' @export
sortable_insert <- function(..., inputId, where = "start", data_id = NULL, session = getDefaultReactiveDomain()) {
    # insert html into a sortable div
    assert_string(inputId)
    assert_choice(where, choices = c("start", "end", "before", "after"))
    assert_string(data_id, null.ok = TRUE)
    if (where %in% c("before", "after") & is.null(data_id)) 
        g_stop("A sortable item's data_id cannot be NULL if where==`{where}`")
    ns <- session_ns(session)
    selector = glue("#{ns(inputId)}")
    if (nnull(data_id) && where %in% c("before", "after")) 
        selector <- glue("{selector} > [data-id=\"{data_id}\"]")
    content <- tagList(...)
    print(selector)
    where <- chr_approx(c("start", "end", "before", "after"), c("afterBegin", 
        "beforeEnd", "beforeBegin", "afterEnd"))(where)
    insertUI(selector, where = where, ui = content, session = session)
    # Returns: \code{[invisible(NULL)]}
}
