#' Create a radio slider input.

#' @name radio_slider_input
#' @param ...
#' @param inputId  \code{[string]}
#' @param label  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param units_label  \code{[NULL]}  Defaults to \code{NULL}.
#' @param choices  \code{[atomic_vector]}
#' @param selected  \code{[choice]}  Possible values: \code{choices}.  NULL is ok.  Defaults to \code{NULL}
#' @param class  \code{[string]}  NULL is ok.  Defaults to \code{'w-100'}
#' @return \code{radio_slider_input}: \code{[html]}
#' @examples

#'  radio_slider_input(inputId = 'myid', choices = names(mtcars))
#' @export
radio_slider_input <- function(..., inputId, label = NULL, units_label = NULL, choices, selected = NULL, class = "w-100") {
    # Create a radio slider input
    dots = list(...)
    if (l(dots) > 0) 
        assert_names(names(dots))
    assert_string(inputId)
    assert_string(label, null.ok = TRUE)
    assert_string(class, null.ok = TRUE)
    assert_atomic_vector(choices)
    assert_choice(selected, choices = choices, null.ok = TRUE)
    drange <- range((0:l(length(choices))))
    selected = c(selected %or% "(All)")
    values = c("(All)", choices)
    selected_val = drange[which(choices == selected)]
    ticks = TRUE
    if (length(choices) > 10) 
        ticks <- FALSE
    ms = function(x) paste0(inputId, "_", x)
    out = div(id = inputId, class = "ao-radio-slider d-flex flex-column w-100", `data-value` = selected, h_arrange(justify = "start", 
        class = "px-1 ao-range-label", label, tags$span(class = "pl-1 label-units", units_label)), flexRow(class = "mb-3 w-100 px-2 border", 
        div(id = ms("max_input"), class = "edit-numeric range-max flex-fill w-100", selected)), flexRow(class = "px-1", 
        sliderInput(paste0(inputId, "_range_slider"), label = NULL, min = min(drange), max = max(drange), 
            step = 1, value = selected_val, ticks = ticks), icon_btn(ms("shift_left"), "chevron-left", class = "border mx-1  shift-left"), 
        icon_btn(ms("shift_right"), "chevron-right", class = "border mr-1 shift-right")), tags$script(toJSON(list(values = values), 
        auto_unbox = TRUE)))
    out %>% tagAppendAttributes(class = class, ...) %>% attachDependencies(html_dependency_ao_radio_slider())
    # Returns: \code{[html]}
}
