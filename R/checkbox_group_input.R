#' Create a radio slider input.

#' @name checkbox_group_input
#' @param ...
#' @param inputId  \code{[string]}
#' @param label  \code{[string]}  NULL is ok.
#' @param choices  \code{[atomic_vector]}
#' @param selected  \code{[choice]}  Possible values: \code{choices}.  NULL is ok.  Defaults to \code{NULL}
#' @param clear_filter  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @param search  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @param options_dropdown  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @return \code{checkbox_group_input}: \code{[html]}
#' @examples

#'  checkbox_group_input(inputId = 'myid', label = 'label', choices = names(mtcars))
#' @export
checkbox_group_input <- function(..., inputId, label, choices, selected = NULL, 
    clear_filter = TRUE, search = TRUE, options_dropdown = TRUE) {
    # Create a radio slider input
    dots = list(...)
    if (l(dots) > 0) 
        assert_names(names(dots))
    assert_string(inputId)
    assert_string(label, null.ok = TRUE)
    assert_atomic_vector(choices)
    assert_choice(selected, choices = choices, null.ok = TRUE)
    assert_logical(clear_filter, len = 1)
    assert_logical(search, len = 1)
    assert_logical(options_dropdown, len = 1)
    ms = function(x) paste0(inputId, "-", x)
    checked <- rep(" checked", l(choices))
    if (nnull(selected)) 
        checked <- (sUtils::chr_approx(c(FALSE, TRUE), c("", " checked")))(choices %in% 
            selected)
    clear_filter_btn = NULL
    if (clear_filter) 
        clear_filter_btn <- icon_btn(ms("clear_filter"), "filter-remove", class = "mdi-sm py-0 text-secondary filter-remove")
    show_search_btn = NULL
    if (search) 
        show_search_btn <- icon_btn(ms("show_search"), "magnify", class = "mdi-sm mag-btn py-0")
    dropdown_btn = NULL
    if (options_dropdown) 
        dropdown_btn <- icon_btn(ms("options"), "menu-down", class = "mdi-sm menu-btn py-0")
    toolbarBtnGroup = NULL
    if (nnull(c(clear_filter_btn, dropdown_btn, show_search_btn))) 
        toolbarBtnGroup <- div(class = "btn-group", clear_filter_btn, dropdown_btn, 
            show_search_btn)
    toolbar <- h_arrange(align = "baseline", span(class = "align-self-end mr-auto checkbox-group-label", 
        label), toolbarBtnGroup)
    checkGroup = div(class = "d-flex flex-column p-1 h-100 checkgroup", lapply(expr_glue(h_arrange(class = "checkbox-row p-0", 
        justify = "start", div(class = " checkbox{checked}", icon_mdi("checkbox-blank-outline", 
            class = "mdi-lg"), icon_mdi("check-box-outline", class = "mdi-lg")), 
        div(class = "ml-2 flex-fill check-label", "{choices}"))), eval))
    out <- flexCol(class = "ao-checkbox-group w-100 h-100", id = inputId, class = "checklist", 
        toolbar, div(class = "mb-1 border search-box  d-none", tags$input(id = ms("search"), 
            type = "text", class = "form-control form-control-sm border-0 shadow-none", 
            placeholder = "Search"), icon_btn(ms("hide_search"), "close", class = "mdi-sm mag-btn py-0")), 
        h_arrange(class = "btn-group", div(class = "btn btn-sm btn-light btn-all py-0 w-50 border", 
            "All"), div(class = "btn btn-sm w-50 btn-none btn-light py-0  border", 
            "None")), checkGroup)
    out %>% tagAppendAttributes(...) %>% attachDependencies(html_dependency_ao_checkbox_group(), 
        append = TRUE)
    # Returns: \code{[html]}
}
