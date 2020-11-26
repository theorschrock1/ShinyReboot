#' Create a navigation item.
#'
#' For use inside navList().

#' @name navItem
#' @param ... Inner HTML.  Usually a text label or icon.
#' @param tab_id  [character] This links to the content area. Must be unique. Must have an exact length of 1.
#' @param class  [character]  Must have an exact length of 1.  NULL is ok.  Defaults to NULL
#' @param active  [logical]  Must have an exact length of 1.  Defaults to FALSE
#' @return \code{navItem}: html
#' @export
navItem <- function(..., tab_id, class = NULL, active = FALSE) {
    # Create a navigation item.  For use inside navList().
    assert_character(tab_id, len = 1)
    assert_character(class, len = 1, null.ok = TRUE)
    assert_logical(active, len = 1)
    selected = js_logical(active)
    actv <- ""
    if (active)
        actv <- " active"
    tags$li(class = paste("nav-item", class), role = "presentation", tags$a(class = paste0("nav-link",
        actv), id = glue("{tab_id}-tab"), `data-toggle` = "tab", href = glue("#{tab_id}"),
        role = "tab", `aria-controls` = tab_id, `aria-selected` = selected, ...))
    # Returns: html
}
